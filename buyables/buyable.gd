extends Node2D
class_name Buyable

const COIN_SFX: Array[AudioStream] = [preload("res://buyables/sfx/coin1.ogg"), preload("res://buyables/sfx/coin2.ogg"), preload("res://buyables/sfx/coin3.ogg"), preload("res://buyables/sfx/coin4.ogg"), preload("res://buyables/sfx/coin5.ogg"), preload("res://buyables/sfx/coin6.ogg"), preload("res://buyables/sfx/coin7.ogg")]

# the id of your buyable
# make sure this is the same as the button ID!!
@export var id: String = ""
@export var stay_on_buy: bool = false

var has_been_bought:bool = false

func _ready() -> void:
	_check_if_bought() # check once when the game starts
	
	# read buyables/button/buyable_button.gd for more info
	Game.buyable_bought.connect(_check_if_bought)

func _check_if_bought():
	if not Game.buyable_bought_list.has(id):
		has_been_bought = false
		visible = false
		process_mode = Node.PROCESS_MODE_DISABLED
		return # we havent bought this buyable yet, stop this function
		
	# this code will only continue if we have bought the buyable
	
	# dont run this again if we've already bought it
	if has_been_bought: return
	
	if not stay_on_buy:
		has_been_bought = true
	
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	_on_buy()

# gets called when the buyable is bought
# has no contents because it will be overwritten by things that extend it
func _on_buy():
	pass

# plays a random coin sound at the selected position
# (or just at the center of the parent provided if no position is passed through)
# vector2s cannot be null, so we're using the value of Vector2(-INF, -INF) to act as somewhat of a
# "null vector2"
# 
# you dont really have to worry about the params if you're just calling this normally
# everything by default (aka just `_play_coin_sound()`) should work
func _play_coin_sound(at: Vector2 = Vector2(-INF, -INF), parent: Node = self):
	var audio_player = AudioStreamPlayer2D.new()
	
	# if we arent our fake "null vector" (aka, we actually passed something through)
	if at != Vector2(-INF, -INF):
		audio_player.global_position = at
	
	parent.add_child(audio_player)
	
	audio_player.stream = COIN_SFX.pick_random()
	audio_player.volume_db = -5
	audio_player.play()
	
	# call queue_free when this audio player finishes playing
	audio_player.finished.connect(audio_player.queue_free)
