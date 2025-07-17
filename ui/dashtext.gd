extends Label

func _process(_delta: float) -> void:
	visible = Game.player.candash
	text = "you can" if Game.player.dashtimer < 0 else "YOU CANT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
	label_settings.shadow_color = Color(0,0.75,0) if Game.player.dashtimer < 0 else Color(1,0,0)
	position = Vector2(77, 434) + (Vector2.from_angle(randf() * 360)*clamp(Game.player.dashtimer, 0, 1)*500)
	rotation = sin(Time.get_ticks_msec() / 2000.0) * 0.05
	# this could be greatly optimized by using a signal whenever money is changed
	# but i dont think it matters
