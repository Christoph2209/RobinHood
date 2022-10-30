extends Node2D

func _ready():
	$Player.position.x = Global.playerx;
	$Player.position.y = Global.playery;
	$AudioStreamPlayer2D.play()
func _save():
	Saver.save_data($Player.position.x,$Player.position.y,Global.boots,Global.fireArrows,Global.bomb,Global.coins, HealthCounter.health)
	
func _load():
	Saver.load_data()


func _on_Shop_body_entered(body):
	if "Player" in body.name:
		Saver.save_data($Player.position.x - 10,$Player.position.y,Global.boots,Global.fireArrows,Global.bomb,Global.coins, HealthCounter.health)
		get_tree().change_scene("res://Entities/Shop.tscn")
	


func _on_Save_body_entered(body):
	if "Player" in body.name:
		Saver.save_data($Save.position.x - 10,$Player.position.y,Global.boots,Global.fireArrows,Global.bomb,Global.coins, HealthCounter.health)


func _on_Level2_body_entered(body):
	if "Player" in body.name:
		Saver.save_data(Global.playerx,Global.playery,Global.boots,Global.fireArrows,Global.bomb,Global.coins, HealthCounter.health)
		get_tree().change_scene("res://Entities/BossFight.tscn")
