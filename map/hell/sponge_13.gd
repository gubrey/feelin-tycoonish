extends Sprite2D

func _process(delta: float) -> void:
	
	position.y = 7022.0 + sin((Time.get_ticks_msec() / 1000.) * 1) *100
	scale.x = 0.095 + sin((Time.get_ticks_msec() / 1) * 50) *1
	scale.y = 0.108 + cos((Time.get_ticks_msec() / 1 ) * 1) *1
