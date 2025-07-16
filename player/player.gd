class_name Player
extends CharacterBody2D

# these are const variables, these cant be modified after the game starts.
# they are usually denoted with CAPITALS
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# these are on ready variables, these get set when the object is created
# the dollar sign means its getting a child node, think of it like a relative file path
@onready var head: Sprite2D = $Head 

# runs when the player is created
func _ready() -> void:
	Game.player = self # sets the global player variable to this node

# if you're confused what "delta" means here:
# https://www.reddit.com/r/gamedev/comments/p1tm4/super_newbish_questionwhat_is_delta_time_how_does/
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction := Input.get_axis("player_left", "player_right") # gets a value between -1 and 1
	if direction != 0: # if its not 0 (aka we're moving)
		velocity.x = direction * SPEED
	else: # if we arent pressing anything
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# handles all the collision math for us, how nice!
	move_and_slide()
	
	#region Head Rotation
	# this is the head rotation code.
	# its its a load a gunk, so try not to worry about it
	# contact me if you need any help with it though
	
	head.rotation = 0
	head.look_at(get_global_mouse_position())
	
	if head.rotation_degrees > 25.0 && head.rotation_degrees < 90.0:
		head.rotation_degrees = 25.0 
	elif head.rotation_degrees < 160.0 && head.rotation_degrees > 90.0:
		head.rotation_degrees = 160.0 
	
	if head.rotation_degrees < -90.0 || head.rotation_degrees > 90.0:
		head.flip_h = false
		head.rotation_degrees += 180
	else:
		head.flip_h = true
	#endregion
	
	
