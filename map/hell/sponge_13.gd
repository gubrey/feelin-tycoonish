extends Sprite2D

func _process(_delta: float) -> void:
	position.y = 7022.0 + sin(Time.get_ticks_msec() / 1000.) * 100.0
	scale.x = 0.095 + sin(Time.get_ticks_msec() * 50)
	scale.y = 0.108 + cos(Time.get_ticks_msec() * 1)
