extends Buyable

const SONGS: Array[AudioStream] = [preload("res://buyables/music_guy/music/Eggs.ogg"), preload("res://buyables/music_guy/music/Hit It.ogg"), preload("res://buyables/music_guy/music/Video Game 1.ogg"), preload("res://buyables/music_guy/music/Widge.ogg")]

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $MusicGuy/AudioStreamPlayer2D

func _on_buy():
	while true:
		audio_stream_player_2d.stream = SONGS.pick_random()
		audio_stream_player_2d.play()
		await audio_stream_player_2d.finished
