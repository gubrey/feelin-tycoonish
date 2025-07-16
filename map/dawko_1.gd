extends Sprite2D

func _process(delta: float) -> void:
	
	position.y = 5799.0 + sin((Time.get_ticks_msec() / 1000.) * 1) *100
