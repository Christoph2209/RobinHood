extends Node2D

func ready ():
	HealthCounter.health = 3
	
func _physics_process(_delta):
	if HealthCounter.health == 4:
		$Health3.visible = true
		$Health2.visible = true
		$Health1.visible = true
		$Temp.visible = true
	elif HealthCounter.health == 3:
		$Health3.visible = true
		$Health2.visible = true
		$Health1.visible = true
		$Temp.visible = false
	elif HealthCounter.health == 2:
		$Health3.visible = false
		$Health2.visible = true
		$Health1.visible = true
		$Temp.visible = false
	elif HealthCounter.health == 1:
		$Health3.visible = false
		$Health2.visible = false
		$Health1.visible = true
		$Temp.visible = false
	elif HealthCounter.health == 0:
		$Health3.visible = false
		$Health2.visible = false
		$Health1.visible = false
		$Temp.visible = false

