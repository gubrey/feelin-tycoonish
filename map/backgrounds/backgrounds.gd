extends Node2D

const FADE_LENGTH = 1.0

var fade_tween: Tween

func _ready() -> void:
	Game.bg_changed.connect(_fade_all_bgs)

func _fade_all_bgs(bg_name: String):
	if fade_tween != null:
		fade_tween.kill()
	
	fade_tween = create_tween()
	
	for child: Node2D in get_children():
		child.visible = true
		
		var target = 0.0 if child.name != bg_name else 1.0
		
		fade_tween.parallel().tween_property(child, "modulate", Color(
			1.0,
			1.0,
			1.0,
			target
		), FADE_LENGTH)
		
		fade_tween.finished.connect(func():
			if target == 0.0:
				child.visible = false
		)
