extends Node2D

func _process(delta):
	position.x += -1 * 130 * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
