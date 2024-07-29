extends CanvasLayer

@onready var lives_label = $Panel/GridContainer/LivesLabel
@onready var speed_label = $Panel/GridContainer/SpeedLabel
@onready var coin_label = $Panel/GridContainer/CoinLabel
var lives_count = 0
var speed_count = 0
var coin_count = 0


func set_lives(count):
	lives_count = count


func set_speed(count):
	speed_count = count


func set_coin(count):
	coin_count = count


func _process(delta):
	lives_label.text = str(lives_count)
	speed_label.text = str(speed_count)
	coin_label.text = str(coin_count)
