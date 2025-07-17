extends Sprite2D

@onready var start_y = position.y

func _process(_delta: float) -> void:
	position.y = start_y + sin((Time.get_ticks_msec() / 1000.) * 1) *100
