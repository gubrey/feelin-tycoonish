extends Buyable

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_buy():
	audio_stream_player_2d.play()
