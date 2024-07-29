extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
	Signals.emit_signal("SnakeDeath")
