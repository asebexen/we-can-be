extends Node2D

# Current target rotation
var current_rotation = 0.0
# Number of times to rotate
@export var max_rotation: float
# How quickly, in radians/second, the spawner rotates
@export var rotation_speed: float
# The interval, in radians, between spawned bullets
@export var rotate_step: float
# Initial velocity of spawned bullets
@export var spawn_velocity: float
# The rotation of the last spawned bullet. Used when calculating spawns to
# decouple spawning behavior from the physics engine (else I could only spawn
# bullets at discrete intervals.)
var last_spawn = 0.0
# Whether or not the spawner is spinning and firing bullets.
@export var is_active: bool
@export var bullet_color: Color

var bullet = load("res://scenes/bullet/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_active == true:
		current_rotation += rotation_speed * delta
	spawn_bullets()

func start_spawn():
	current_rotation = 0.0
	last_spawn = 0.0
	is_active = true

func spawn_bullets():
	var next_spawn = last_spawn + rotate_step
	while next_spawn <= current_rotation:
		var bullet_instance = bullet.instantiate()
		bullet_instance.linear_velocity = Vector2.UP.rotated(next_spawn) * spawn_velocity
		bullet_instance.color = bullet_color
		last_spawn = next_spawn
		next_spawn = last_spawn + rotate_step
		add_child(bullet_instance)
	if current_rotation > max_rotation:
		is_active = false
