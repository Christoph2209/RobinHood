extends KinematicBody2D
var SPEED = 200
const GRAVITY = 10
const JUMP_POWER = -250
const FLOOR = Vector2(0, -1)
const ARROW = preload("res://Entities/Arrow.tscn")
const FARROW = preload("res://Entities/FireArrow.tscn")
enum{
	UP,
	CROUCH,
	HURT
}
var knockback = Vector2.ZERO
var state = UP
var fireball_power = 1
var velocity = Vector2()
var on_ground = false
var is_attacking = false
var is_dead = false #Adds a boolean that determines Player Death
var kind = 1
var S = ""
var dmg
func _physics_process(delta):
	match state:
		UP:
			up_state(delta)
		CROUCH:
			crouch_state(delta)
		HURT:
			hurt_state(delta)
			
			
func change_state(S, dag):
	S.to_upper()
	if(S == "HURT"):
		state = HURT
		dmg = dag


func hurt_state(delta):
	dead(dmg)
	if sign($Position2D.position.x) == 1: 
		position.x -= 20
		$HurtBox.set_deferred("disabled", true)
		$HurtBoxSmall.set_deferred("disabled", true)
	if sign($Position2D.position.x) == -1:
		position.x += 20
		$HurtBox.set_deferred("disabled", true)
		$HurtBoxSmall.set_deferred("disabled", true)
	state = UP
func up_state(delta):
	if is_dead == false:
		$HurtBox.disabled = false
		$HurtBoxSmall.disabled = true
# This adds a check to see if player is dead.
# All that follows only happens if player is alive and needs to be indented
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED
			$Sprite.flip_h = false
			$Sprite.play("walk")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED
			if is_attacking == false:
				$Sprite.flip_h = true
				$Sprite.play("walk")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			velocity.x = 0
			$Sprite.play("default")
		
		if Input.is_action_pressed("ui_down"):
			state = CROUCH
		if Input.is_action_just_released("ui_down"):
			$HurtBox.disabled = false
			$HurtBoxSmall.disabled = true

		#Jump
		if Input.is_action_pressed("ui_up"):
			if on_ground == true:
				$Sprite.play("jump")
				$Jump.play()
				if Global.jump >= 0:
					velocity.y = JUMP_POWER
					on_ground = false
					Global.jump -= 1
		if Input.is_action_just_pressed("ui_up") and on_ground == false:
			if Global.jval == 2 && Global.jump == 1:
				velocity.y = JUMP_POWER
				Global.jump -= 1
				$DoubleJump.play()
		#Arrows
		if Input.is_action_just_pressed("ui_focus_next"):
			Global.fire()
			var fireball = ARROW.instance()
			if kind == 1 || Global.fireArrows == 0:
				$Shoot.play()
				fireball = ARROW.instance()
			if kind == 2:
				$Fire.play()
				fireball = FARROW.instance()
				Global.fireArrows -= 1
				if(Global.fireArrows == 0):
					kind = 1
			# this signifies a distinction between the two different fireballs
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
		
		#Change from Fire to not fire
		if Global.has_fireArrows == true:
			if Input.is_action_just_pressed("ui_focus_prev"):
				if kind == 1:
					kind = 2
				elif kind ==2:
					kind = 1
		elif Global.has_fireArrows == false:
			kind == 1
				
		velocity.y += GRAVITY
		if is_on_floor():
			Global.booties()
			if on_ground == false:
				is_attacking = false
				on_ground = true
				Global.jump = Global.jval
			else:
				if is_attacking == false:
					on_ground = false

		velocity = move_and_slide(velocity, FLOOR)
		
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					state = HURT
		
func crouch_state(delta):
	if is_dead == false:
# This adds a check to see if player is dead.
# All that follows only happens if player is alive and needs to be indented
		$HurtBox.disabled = true
		$HurtBoxSmall.disabled = false
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED/2
			$Sprite.flip_h = false
			$Sprite.play("cwalk")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED/2
			if is_attacking == false:
				$Sprite.flip_h = true
				$Sprite.play("cwalk")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			velocity.x = 0
			$Sprite.play("crouch")
		
		if Input.is_action_pressed("ui_down"):
			state = CROUCH
		if Input.is_action_just_released("ui_down"):
			state = UP

		#Jump
		if Input.is_action_pressed("ui_up"):
			if on_ground == true:
				$Sprite.play("jump")
				$Jump.play()
				if Global.jump >= 0:
					velocity.y = JUMP_POWER
					on_ground = false
					Global.jump -= 1
		if Input.is_action_just_pressed("ui_up") and on_ground == false:
			if Global.jval == 2 && Global.jump == 1:
				velocity.y = JUMP_POWER
				Global.jump -= 1
				$DoubleJump.play()
		#Arrows
		if Input.is_action_just_pressed("ui_focus_next"):
			Global.fire()
			var fireball = ARROW.instance()
			$Shoot.play()
			if kind == 1 || Global.fireArrows == 0:
				fireball = ARROW.instance()
			if kind == 2:
				fireball = FARROW.instance()
				Global.fireArrows -= 1
				if(Global.fireArrows == 0):
					kind = 1
			# this signifies a distinction between the two different fireballs
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
		
		#Change from Fire to not fire
		if Global.has_fireArrows == true:
			if Input.is_action_just_pressed("ui_focus_prev"):
				if kind == 1:
					kind = 2
				elif kind ==2:
					kind = 1
		elif Global.has_fireArrows == false:
			kind == 1
				
		velocity.y += GRAVITY
		if is_on_floor():
			Global.booties()
			if on_ground == false:
				is_attacking = false
				on_ground = true
				Global.jump = Global.jval
			else:
				if is_attacking == false:
					on_ground = false

		velocity = move_and_slide(velocity, FLOOR)
		if get_slide_count() > 0:
			for i in range(get_slide_count()):
				if "Enemy" in get_slide_collision(i).collider.name:
					state = HURT

func dead(dmg):
	HealthCounter.health -= dmg
	$Death.play()
	if HealthCounter.health <= 0:
		death()
# This creates act
func death():
	get_tree().change_scene("res://Entities/GameOver.tscn")
func spd_up():
	SPEED +=100
	$PowerUp.play()
	
func jmp_up():
	Global.boots = 1
	Global.has_boots = true
	Global.jump = 2
	Global.jval = 2
	$PowerUp.play()
func hp_up():
	if HealthCounter.health != 3:
		HealthCounter.health += 1
	$PowerUp.play()
func pwr_up():
	Global.fire()
	fireball_power = 3
	$PowerUp.play()

func temp_hp():
	HealthCounter.health += 1
	$PowerUp.play()
func _on_Timer_timeout():
	get_tree().change_scene("res://Entities/TitleScreen.tscn")
	HealthCounter.health = 3;


func _on_InvulnerabilityTimer_timeout():
	$HurtBox.disabled = false
	$HurtBoxSmall.disabled = false
	velocity.y += GRAVITY


func _on_Timer2_timeout():
	state = UP
	$HurtBox.set_deferred("disabled", false)
	$HurtBoxSmall.set_deferred("disabled", false)
