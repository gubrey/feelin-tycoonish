extends TextureRect

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var timer: Timer = $Timer

func _ready() -> void:
	Game.player_died.connect(_show_death_screen)

func _show_death_screen():
	audio_stream_player.play()
	show()
	
	timer.start()
	await timer.timeout
	
	hide()
	audio_stream_player.stop()
