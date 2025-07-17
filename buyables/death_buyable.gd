extends Buyable

func _on_buy():
	Game.player.position = Game.player.spawn_pos
