extends Node

# this is set as a global in the project settings
# it can be accessed anywhere by writing Game
# its created outside of the game tree, and always exists

var money:int = 0

# every buyable thats been bought
var buyable_bought_list:Array[String]

# the player may not be set immediately, so watch out when writing your code.
# you can avoid an error by doing this before accessing Game.player:

# if Game.player == null:
#	await Game.player_created

var player:Player:
	set(value):
		var was_null = (player == null)
		
		player = value
		
		if was_null:
			player_created.emit()

signal player_created
signal buyable_bought

# function to call when you buy a buyable
func buy_buyable(id: String) -> void:
	buyable_bought_list.append(id)
	buyable_bought.emit()

func _process(_delta: float) -> void:
	# if we're holding TAB (defined in project settings)
	if Input.is_action_pressed("debug_speed") and OS.is_debug_build():
		Engine.time_scale = 25
	else:
		Engine.time_scale = 1
	
	if Input.is_action_just_pressed("debug_money"):
		money += 1000
	
