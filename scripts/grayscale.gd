extends Sprite2D

@onready var camera_2d = $".."

func _process(delta):
	position = camera_2d.position
