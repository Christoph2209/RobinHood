extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play();


func _on_EndButton_pressed():
	get_tree().quit()


func _on_RestButton_pressed():
	Saver.load_data()
	get_tree().change_scene("res://Entities/StageOne.tscn")
