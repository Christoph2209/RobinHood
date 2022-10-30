extends Control

var is_paused = false setget set_is_paused


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.is_paused = !is_paused

func set_is_paused(value):
	is_paused = value
	get_tree().paused = is_paused
	visible = is_paused
	if(is_paused == true):
		$AudioStreamPlayer.play()

func _on_NewGame_pressed():
	get_tree().change_scene("res://Entities/StageOne.tscn")
	Saver.save_data(32,544,0,0,0,0,3)
	self.is_paused = false
	$AudioStreamPlayer.stop()
	
func _on_LoadGame_pressed():
	Saver.load_data()
	get_tree().change_scene("res://Entities/StageOne.tscn")
	self.is_paused = false
	$AudioStreamPlayer.stop()
func _on_ExitGame_pressed():
	get_tree().quit()
	

func _on_Button_pressed():
	$AudioStreamPlayer.stop()
	self.is_paused = false
	$AudioStreamPlayer.stop()
