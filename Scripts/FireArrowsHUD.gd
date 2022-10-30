extends Node2D




func _process(_delta):
	if Global.fireArrows > 0:
		$Sprite.visible = true
		$Label.text = str(Global.fireArrows)
	else:
		$Sprite.visible = false
		$Label.text = str("")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

