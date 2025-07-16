extends Label


func _process(_delta: float) -> void:
	# %s lets you insert a variable into the string
	# read buyables/button/buyable_button.gd for more info
	text = "MONEY: %s$" % Game.money
	
	# this could be greatly optimized by using a signal whenever money is changed
	# but i dont think it matters
