extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var talking_speech_bubble: TalkingSpeechBubble = $TalkingSpeechBubble

var is_dancing = false

func _ready() -> void:
	Game.buyable_bought.connect(on_buyable_bought)

func on_buyable_bought():
	if Game.buyable_bought_list.has('music_man') and not is_dancing:
		animation_player.play("bop")
		is_dancing = true

func _on_talk_hitbox_body_entered(body: Node2D) -> void:
	if body == Game.player && !talking_speech_bubble.talking:
		if is_dancing:
			talking_speech_bubble.say("Woah! Nice music man", 1.0 / 30.0, 2)
		else:
			talking_speech_bubble.say("i am ouiyer", 1.0 / 30.0, 1)
