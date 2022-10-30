extends Control

func _ready():
	$AudioStreamPlayer2D.play()
	$Timer.start()
	$Label3.visible = false
	$Label2.visible = false
	$Label.visible = false
	$Sprite2.play("talk")
	
func _process(delta):
	pass
	
func _buy(price):
	if Global.coins - price > 0:
		Global.coins -= price
		$AudioStreamPlayer.play()
		
func _on_Button_pressed():
	if Global.coins - 20 >= 0:
		_buy(20) # Replace with function body.
		Global.fireArrows += 5


func _on_Button2_pressed():
	if Global.coins - 10 >= 0:
		if HealthCounter.health <= 2:
			_buy(10) # Replace with function body.
			HealthCounter.health += 1

	
func _on_Button3_pressed():
	if Global.coins - 50 > 0:
		if HealthCounter.health == 3:
			_buy(50) # Replace with function body.
			HealthCounter.health += 1


func _on_Button4_pressed():
	get_tree().change_scene("res://Entities/StageOne.tscn")


func _on_Timer_timeout():
	$header.visible = false
	$Sprite2.play("smile")

func _on_Button2_mouse_entered():
	$Label3.visible = true
	$header.visible = false
	$Sprite2.play("talk")

func _on_Button2_mouse_exited():
	$Label3.visible = false
	$Sprite2.play("smile")

func _on_Button_mouse_entered():
	$Label2.visible = true
	$header.visible = false
	$Sprite2.play("talk")

func _on_Button_mouse_exited():
	$Label2.visible = false
	$Sprite2.play("smile")

func _on_Button3_mouse_entered():
	$Label.visible = true
	$header.visible = false
	$Sprite2.play("talk")

func _on_Button3_mouse_exited():
	$Label.visible = false
	$Sprite2.play("smile")
