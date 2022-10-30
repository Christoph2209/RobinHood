extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Newgame_pressed():
	get_tree().change_scene("res://Entities/StageOne.tscn")
	Saver.save_data(32,544,0,0,0,0,3)

func _on_LoadGame_pressed():
	Saver.load_data()
	get_tree().change_scene("res://Entities/StageOne.tscn")


func _on_Quit_pressed():
	get_tree().quit()
