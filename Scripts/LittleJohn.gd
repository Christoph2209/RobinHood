extends KinematicBody2D
const GRAVITY = 10
const SPEED = 100
const FLOOR = Vector2(0, -1)

enum {
	MOVE,
	ATTACK,
}

var velocity = Vector2()
var direction = 1
var is_dead = false
var a = 1
var state = MOVE
var prev = 0

var p = preload("res://Entities/Player.tscn")

var state_machine
onready var aPlayer = $AnimationPlayer
export (int) var health = 1
func _ready():
	state_machine = $AnimationTree.get("parameters/playback")
	
func dead(dmg):
	health -= dmg
	if health <= 0:
		is_dead = true
		velocity = Vector2(0, 0)
		state_machine.travel("dead")
		$Hurtbox.set_deferred("disabled", true)
		$Timer.start()
		$AudioStreamPlayer2D.play()
		
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		
		ATTACK:
			attack_state(delta)
		


func move_state(delta):
	if is_dead == false:
		$indicator/BatIndicator.disabled = false
		state_machine.travel("Walk")
		velocity.x = SPEED * direction
		if direction == 1:
			$Sprite.flip_h = false
			$Sprite.position.x = 0
			$indicator/BatIndicator.position.x = 8
			$attack/BatAttack.position.x = 12
		else:
			$Sprite.flip_h = true
			$Sprite.position.x = -14
			$attack/BatAttack.position.x = -28
			$indicator/BatIndicator.position.x = -24
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		direction = direction * -1
		
		
	


func attack_state(delta):
	prev = velocity
	velocity = Vector2(0,0)
	state_machine.travel("attack")
	$indicator/BatIndicator.disabled = true

func _on_Timer_timeout():
	queue_free()
	get_tree().change_scene("res://Entities/Congrats.tscn")
func attack_animation_finished():
	state = MOVE


func _on_indicator_body_entered(body):
	if "Player" in body.name:
		state = ATTACK


func _on_attack_body_entered(body):
	if "Player" in body.name:
		body.change_state("HURT",2)
