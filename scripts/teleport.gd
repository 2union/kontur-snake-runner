extends Area2D

@export var coordinates: Vector2
@onready var player = $"../Snakes/Player"
@onready var player_2 = $"../Snakes/Player2"
@onready var camera_2d = $"../Snakes/Player/Camera2D"
@onready var visible_on_screen_notifier_2d = $"../Snakes/Player2/VisibleOnScreenNotifier2D"


func _on_body_entered(body):
	visible_on_screen_notifier_2d.set_block_signals(true)
	player.global_position = Vector2(-3080, -26)
	player_2.global_position = Vector2(-3080, 43)
	camera_2d.reset_smoothing()
	visible_on_screen_notifier_2d.set_block_signals(false)
