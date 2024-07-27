extends Node2D

# Current elapsed time
var time_elapsed: float = 0.0
# Spawn rate, in seconds
@export var spawn_rate: float
# Number of bullets to spawn
@export var spawn_count_max: int
var spawn_count = 0
@export var spawn_velocity: float
# The rotation of the last spawned bullet. Used when calculating spawns to
# decouple spawning behavior from the physics engine (else I could only spawn
# bullets at discrete intervals.)
var last_spawn = 0.0
@export var bullet_color: Color

signal done

var bullet = load("res://scenes/game/bullet/bullet.tscn")
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().root.get_node("/root/Game/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed += delta
	spawn_bullets()


func spawn_bullets():
	var next_spawn = last_spawn + spawn_rate
	while next_spawn <= time_elapsed:
		spawn_count += 1
		var bullet_instance = bullet.instantiate()
		var target_vector = (player.position - position).normalized()
		bullet_instance.linear_velocity = target_vector * spawn_velocity
		bullet_instance.color = bullet_color
		# Bullets are added into the parent container
		bullet_instance.position += position
		# Initial offset, needed in case of eg: major lag
		bullet_instance.position += target_vector * spawn_velocity * (time_elapsed - next_spawn)
		last_spawn = next_spawn
		next_spawn = last_spawn + spawn_rate
		get_parent().add_child(bullet_instance)
	if spawn_count >= spawn_count_max:
		done.emit()
		queue_free()
