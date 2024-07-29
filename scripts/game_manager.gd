extends Node

@onready var final_message = %FinalMessage
@onready var best_try_message = %BestTryMessage
@onready var top_score_message = %TopScoreMessage
@onready var prev_try_message = %PrevTryMessage
@onready var player = $"../Snakes/Player"
@onready var player_2 = $"../Snakes/Player2"
@onready var death_timer = $DeathTimer
@onready var death_sound = $DeathSound
@onready var guido = $"../Guido"
@onready var ui = $"../UI"
@onready var guido_text = $"../Guido/GuidoText"
@onready var dialog_timer = $"../Guido/Timer"

var is_alive: bool = true
var skip_counter = 0
var score = 0
var speed = 60.0
var final_message_text = ""
var best_try_message_text = ""
var top_score_message_text = ""
var prev_try_message_text = ""
var dialog = """
Hey, Python!
Looks like you too
slow! I think it's 
time to do 
something with it.
"""
var dialog_two = """
I did this training
center to make you
faster!
"""
var dialog_three = """
Now run and don't
forget about both
of your parts!
"""

var dialog_four = """
GO!
"""

var dialogs = [dialog, dialog_two, dialog_three, dialog_four]

func select_dialog():
	if len(dialogs) == 1:
		dialog_timer.queue_free()
		guido_text.text = dialogs.pop_front()
		just_run()
	else:
		guido_text.text = dialogs.pop_front()

func run_with_dialog():
	player.set_animation("idle")
	player_2.set_animation("idle")
	speed = 0.0
	get_tree().paused = true
	Global.skip_intro = true
	select_dialog()

func just_run():
	player.set_animation("run")
	player_2.set_animation("run")
	guido_text.text = dialog_four
	speed = 60.0

func _ready():
	Signals.connect("SnakeDeath", self.death)
	final_message_text = final_message.text
	best_try_message_text = best_try_message.text
	top_score_message_text = top_score_message.text
	prev_try_message_text = prev_try_message.text
	best_try_message.text = best_try_message_text % Global.best_try
	top_score_message.text = top_score_message_text % Global.best_result
	prev_try_message.text = prev_try_message_text % Global.previous_best_try
	if Global.skip_intro:
		just_run()
	else:
		run_with_dialog()
	player.speed = speed
	player_2.speed = speed
	ui.set_coin(score)
	ui.set_speed(int(speed))
	ui.set_lives(Global.lives)

@warning_ignore("unused_parameter")
func _physics_process(delta):
	player_2.speed = speed
	player.speed = speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	death()

func _on_death_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	Music.play()

func add_point():
	score += 1
	speed += 5.0
	ui.set_speed(int(speed))
	ui.set_coin(score)
	final_message.text = final_message_text % score

func power_up():
	player.add_jump()
	player_2.add_jump()

func rebuild_the_game():
	if Global.best_try > Global.best_result:
		Global.best_result = Global.best_try
	Global.previous_best_try = Global.best_try
	Global.best_try = 0
	Global.lives = 5
	Global.skip_intro = false


func death():
	if is_alive:
		Global.lives -= 1
		ui.set_lives(Global.lives)
		if score > Global.best_try:
			Global.best_try = score
		if Global.lives < 1:
			rebuild_the_game()
		is_alive = false		
		Music.stop()
		death_sound.play()
		Engine.time_scale = 0.5
		player.get_node("CollisionShape2D").queue_free()
		player_2.get_node("CollisionShape2D").queue_free()
		death_timer.start()


func _on_guido_on_screen_notifier_screen_exited():
	guido.queue_free()


func _on_timer_timeout():
	select_dialog()

func _unhandled_input(event):
	if Input.is_action_pressed("jump"):
		if get_tree().paused:
			get_tree().paused = false
		if speed == 0.0:
			skip_counter += 1
		if skip_counter > 2:
			skip_counter = 0
			dialog_timer.queue_free()
			guido_text.text = dialog_four
			just_run()
