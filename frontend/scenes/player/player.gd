extends CharacterBody2D

var can_jump = false
var dir = 0
var move_speed = 600
var jump_velocity = 900

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_walk(delta)
	velocity[1] += GamePhysics.GRAVITY * delta
	process_jump()
	move_and_slide()
	check_refresh_jump()

func process_walk(delta):
	dir = 0
	var coeff = 1.0
	if Input.is_action_pressed("move_right"):
		dir += 1
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if Input.is_action_pressed("move_slow"):
		coeff /= 2
	velocity[0] = dir * move_speed * coeff
	
func process_jump():
	if Input.is_action_pressed("move_jump") and can_jump == true:
		velocity[1] = -jump_velocity
		can_jump = false
	
func check_refresh_jump():
	for i in range(0, get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision != null and collision.get_collider().is_in_group("floor"):
			can_jump = true
