extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
			body.pwr_up()
			Global.fireArrows += 5
	queue_free()


func _on_Shop2_body_entered(body):
	pass # Replace with function body.


func _on_Shop_body_entered(body):
	pass # Replace with function body.
