extends Node2D
export var sprite = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	if(sprite == 1):
		$Sprite.play("rock");
	elif (sprite == 2):
		$Sprite.play("wood")
		
func dead():
	$Hurtbox.set_deferred("disabled", true)
	$Sprite.visible = false
