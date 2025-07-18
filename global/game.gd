extends Node

# this is set as a global in the project settings
# it can be accessed anywhere by writing Game
# its created outside of the game tree, and always exists

var money:int = 0
var money2:int = 0

# every buyable thats been bought
var buyable_bought_list:Array[String]

# the name of the current background
var current_bg: String = ""

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

## use kill_player() to kill the player!!!!
signal player_died
## use change_bg() to change the bg!!!! 
signal bg_changed

# function to call when you buy a buyable
func buy_buyable(id: String) -> void:
	buyable_bought_list.append(id)
	buyable_bought.emit()

func _process(_delta: float) -> void:
	if OS.is_debug_build():
		# if we're holding TAB (defined in project settings)
		if Input.is_action_pressed("debug_speed"):
			Engine.time_scale = 25
		else:
			Engine.time_scale = 1
		
		# if we just pressed "\"
		if Input.is_action_just_pressed("debug_money"):
			money += 1000

# call this to, you guessed it, kill the player!
func kill_player():
	money = 0
	player_died.emit()

func change_bg(bg_name: String):
	current_bg = bg_name
	bg_changed.emit(current_bg)
