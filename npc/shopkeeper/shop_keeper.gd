extends AnimatedSprite2D
var isdancing = false

func _ready() -> void:
	Game.buyable_bought.connect(onbuyablebought)

func onbuyablebought():
	if Game.buyable_bought_list.has('music_man') and not isdancing:
		play("dance")
		isdancing = true
