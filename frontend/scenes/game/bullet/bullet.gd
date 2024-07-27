extends RigidBody2D

const BOUNDS_PADDING = 500
var bounds
@export var color: Color

# Called when the node enters the scene tree for the first time.
func _ready():
	bounds = [Vector2(-BOUNDS_PADDING, -BOUNDS_PADDING), get_viewport_rect().size + Vector2(BOUNDS_PADDING, BOUNDS_PADDING)]
	$ColorRect.color = color

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_should_die()
	
func check_should_die():
	var global_pos = get_global_transform().get_origin()
	if (global_pos[0] < bounds[0][0]
	or global_pos[0] > bounds[1][0]
	or global_pos[1] < bounds[0][1]
	or global_pos[1] > bounds[1][1]):
		queue_free()

