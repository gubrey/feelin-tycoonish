class_name BuyableButton
extends Node2D

# constant references to the sound files
const BUY_SUCCESS = preload("res://buyables/button/buy.wav")
const BUY_FAIL = preload("res://buyables/button/buy_fail.mp3")

# the ID this buyable will be known by
@export var buyable_id: String = ""

# @export means we can edit it in the inspector window
@export var buyable_name: String = "":
	# this gets run every time you set buyable_name to something
	set(value):
		# when we do this, the variable doesnt get changed until we change it ourselves
		buyable_name = value
		
		# if we arent "ready" (aka fully created)
		# stop the code until we are
		if !is_node_ready():
			await ready
		
		text_name.text = "Buy " + buyable_name
		

@export var price: int = -1:
	# same as above
	set(value):
		price = value
		
		if !is_node_ready():
			await ready
		
		# writing "%s" in a string lets us replace it by putting a variable after a %
		# https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_format_string.html
		price_label.text = "%s$" % price

# the list of IDs this button requires to be bought before showing
@export var requires: Array[String] = []

@onready var text_name: RichTextLabel = $TextName
@onready var button: Area2D = $Button
@onready var price_label: RichTextLabel = $TextName/Price
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	_check_if_can_show() # check once when the game starts
	
	# "buyable_bought" is a signal, using "connect" on it means it will call
	# the function specified every time its emitted
	# https://docs.godotengine.org/en/4.4/getting_started/step_by_step/signals.html
	Game.buyable_bought.connect(_check_if_can_show)

func _check_if_can_show():
	for id in requires:
		if not Game.buyable_bought_list.has(id):
			visible = false
			return # we havent gotten this id yet, stop this function
		
	# this code will only continue if we have bought all the requirements
	visible = true

# this is also an event, but its connected outside of the script
# using the "Node" tab on the button
func _on_button_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	# dont continue code if this isnt a mouse button event
	if event is not InputEventMouseButton: return
	
	# if its a press event, and the button is the left mouse button (1)
	if event.pressed && event.button_index == 1:
		_buy_buyable()

func _buy_buyable():
	# if we're broke
	if Game.money < price:
		audio_player.stream = BUY_FAIL # sets the stream of the player to the "BUY_FAIL" file
		audio_player.play() # calls the "play" function to play the file
		return # stop the code
	
	# this code will only continue if we can sucessfully buy the buyable
	Game.money -= price # so we can safely assume we have enough money
	
	# call the function to tell the game that we've bought this buyable
	Game.buy_buyable(buyable_id)
	visible = false # hide the buyable
	
	audio_player.stream = BUY_SUCCESS # same as before but with "BUY_SUCCESS"
	audio_player.play()
	
	# now, normally we would call "queue_free()" right here to delete the node
	# but, we're playing a sound, and deleting the node would stop the sound
	# so we have to wait for the sound to finish before deleting the node
	
	# this makes the node & its children no longer call the "process" functions
	# the stream node has an override on this though, so it wont be paused.
	# this is manually set in the "process" section in the inspector
	process_mode = Node.PROCESS_MODE_DISABLED
	await audio_player.finished
	
	queue_free()
