extends Node2D
class_name Buyable

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
