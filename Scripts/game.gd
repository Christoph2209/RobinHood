extends Node

var coins
func _process(delta):
	$Label.text = str(Global.coins)
	
func add_coins():
	Global.coins += 10
