extends KinematicBody2D
const GRAVITY = 10
const SPEED = 100
const FLOOR = Vector2(0, -1)
var velocity = Vector2()
var direction = 1
var is_dead = false
export (int) var size = 1
export (int) var health = 1
func _ready():
	pass
func dead(dmg):
	health -= dmg
	if health <= 0:
		is_dead = true
		velocity = Vector2(0, 0)
		$Sprite.play("dead")
		$Sprite.position.y = 9.5
		$AudioStreamPlayer.play()
		$Hurtbox.set_deferred("disabled", true)
		$Timer.start()
func _physics_process(_delta):
	if is_dead == false:
		$Sprite.play("walk")
		velocity.x = SPEED * direction
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true
		velocity.y += GRAVITY
		velocity = move_and_slide(velocity, FLOOR)
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	if get_slide_count() > 0:
		for i in range (get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.change_state("HURT", 1)
# Continues the designation between colliding with Enemy
# or colliding with Walls
func _on_Timer_timeout():
	queue_free()
