extends Node2D

@export var cannonball: PackedScene
@onready var ray_cast = $RayCast2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var shot_sound = $ShotSound


var can_shot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast.is_colliding() and can_shot:
		animated_sprite.play("fire")
		shot_sound.play()
		var ball = cannonball.instantiate()
		var spawn_location = get_node("Area2D/CollisionShape2D")
		ball.position = spawn_location.position
		add_child(ball)
		can_shot = false


func _on_timer_timeout():
	can_shot = true


func _on_visible_on_screen_notifier_2d_screen_entered():
	timer.start()
