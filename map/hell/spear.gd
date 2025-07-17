extends Node2D

func _process(_delta: float) -> void:
	rotation = 90 + sin(Time.get_ticks_msec() / 10000.) * 100
