extends Sprite2D

@onready var start_y = position.y

func _process(_delta: float) -> void:
	position.y = start_y + sin(Time.get_ticks_msec() / 1000.) * 100.0
	scale.x = 0.095 + sin(Time.get_ticks_msec() * 50)
	scale.y = 0.108 + cos(Time.get_ticks_msec() * 1)
