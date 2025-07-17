extends Buyable
	
var honseSfx: AudioStream = preload("res://buyables/honse/honse_sfx.mp3")

# this was stolen entirely from buyable.gd lmao
func honse_sound(at: Vector2 = Vector2(-INF, -INF), parent: Node = self):
	var audio_player = AudioStreamPlayer2D.new()
	if at != Vector2(-INF, -INF):
		audio_player.global_position = at
	parent.add_child(audio_player)
	audio_player.stream = honseSfx
	audio_player.volume_db = 5
	audio_player.play()
	audio_player.finished.connect(audio_player.queue_free)

func honse_appear():
	$Honse.offset = Vector2(-100, 0)

func _on_buy():
	honse_appear()
	honse_sound()
	return
