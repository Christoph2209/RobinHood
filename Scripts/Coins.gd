extends Area2D

export(int)var val = 1;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Node2D_body_entered(body):
	if "Player" in body.name:
		Global.gain_coins(val)
		$Timer.start()
		$Sprite.visible = false
		$AudioStreamPlayer2D.play()



func _on_Timer_timeout():
	queue_free()
