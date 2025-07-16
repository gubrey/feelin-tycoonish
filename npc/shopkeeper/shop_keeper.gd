extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var isdancing = false

func _ready() -> void:
	Game.buyable_bought.connect(onbuyablebought)

func onbuyablebought():
	if Game.buyable_bought_list.has('music_man') and not isdancing:
		animation_player.play("bop")
		isdancing = true
