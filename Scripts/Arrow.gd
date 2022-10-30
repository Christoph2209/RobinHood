extends Area2D
const SPEED = 400
var velocity = Vector2()
var direction = 1
func _ready():
	pass
func set_fireball_direction(dir):
	direction = dir
	if dir == -1:
		$Sprite.flip_h = true
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
#Below code adds the collision reaction when a fireball hits Enemy
func _on_Arrow_body_entered(body):
	if "Enemy" in body.name:
		body.dead(1)
	if "breakableWall" in body.name:
		body.dead()
	if "LittleJohn" in body.name:
		body.dead(1)
	queue_free()
