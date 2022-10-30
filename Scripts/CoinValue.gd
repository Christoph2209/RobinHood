extends Node2D



func _process(_delta):
	$Label.text = str(Global.coins)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
