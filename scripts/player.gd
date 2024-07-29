extends CharacterBody2D


const JUMP_VELOCITY = -300.0
var jumps = 0
@export var speed = 0.0
var count_of_extra_jumps = jumps
var animation = "idle"

@onready var animated_sprite = $AnimatedSprite2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func set_animation(animation_name: String) -> void:
	animation = animation_name


func add_jump():
	jumps += 1
	count_of_extra_jumps = jumps


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		count_of_extra_jumps = jumps

	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or count_of_extra_jumps>0):
		if not is_on_floor():
			count_of_extra_jumps -= 1
		velocity.y = JUMP_VELOCITY

	if is_on_floor():
		animated_sprite.play(animation)
	else:
		animated_sprite.play("jump")

	velocity.x = speed

	move_and_slide()
