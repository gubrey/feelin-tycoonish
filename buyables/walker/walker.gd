# this extends the buyable script, so it has all the functionality that it has
# you can press CTRL + Click on anything you dont understand
extends Buyable

@onready var potasium: AnimatedSprite2D = $Potasium

var walking_time: float = 3.0
var value: int = 2

func _ready():
	super()
	Game.buyable_bought.connect(_buyable_bought)

func _buyable_bought():
	if Game.buyable_bought_list.has(id + "_upgrade0"):
		walking_time = 1.5
	
	if Game.buyable_bought_list.has(id + "_upgrade1"):
		value = 4

func _on_buy():
	potasium.position = Vector2(-190, -30)
	
	# basically a forever loop. be careful, if these get stuck the game will freeze!
	# use "break" to edit out of them
	while true:
		# play his idle animation
		potasium.play("idle")
		
		# wait before walking
		await get_tree().create_timer(walking_time / 3.0).timeout
		
		# creates a tween
		var tween = create_tween()
		
		# tweens the position variable to "190, -30" over 3 seconds
		# tween instances cannot be reused once they have been started,
		# make sure to recreate them by doing `tween = create_tween()`!
		tween.tween_property(potasium, "position", Vector2(190, -30), walking_time)
		
		# plays his walk animation
		potasium.play("walk")
		
		# wait for the tween to finish...
		await tween.finished
		
		Game.money += value
		# this function takes in global coordinates, so we need to convert it accordingly
		_play_coin_sound(to_global(Vector2(259, -45)))
		
		# plays his idle animation
		potasium.play("idle")
		
		# wait before walking
		await get_tree().create_timer(walking_time / 3.0).timeout
		
		# walk back
		potasium.flip_h = true
		
		# the tween instance has become stale, we must make a new one
		# stale = its gross and moldy, dont eat it. ew.
		tween = create_tween()
		tween.tween_property(potasium, "position", Vector2(-190, -30), walking_time)
		potasium.play("walk")
		
		await tween.finished
		
		potasium.flip_h = false
