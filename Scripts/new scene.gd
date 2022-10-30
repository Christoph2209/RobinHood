extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _process(_delta):
	$Label.text = str(HealthCounter.health)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
