extends Area2D

@export var bg_name: String

func _on_body_entered(body: Node2D) -> void:
	if body == Game.player:
		Game.bg_changed.emit(bg_name)
