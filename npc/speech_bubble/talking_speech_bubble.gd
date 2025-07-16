class_name TalkingSpeechBubble
extends SpeechBubble

const WAIT_CHARS = [".", ",", ";", "!", "?"]

@export var sound: AudioStream

@onready var talk_player: AudioStreamPlayer2D = $TalkPlayer

var talking: bool = false

func _ready():
	hide()

# lower speed = faster
func say(string: String, speed: float = 1.0 / 30.0, show_time: float = 0.5):
	if talking: return
	
	talking = true
	
	show()
	text = ""
	talk_player.stream = sound
	
	var split_string = string.split("")
	
	for letter in split_string:
		text += letter
		
		talk_player.stop()
		talk_player.play()
		
		var wait_time = speed
		
		if WAIT_CHARS.has(letter):
			wait_time *= 4
		
		await get_tree().create_timer(wait_time).timeout
	
	await get_tree().create_timer(show_time).timeout
	hide()
	
	talking = false
	return
