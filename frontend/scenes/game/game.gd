extends Node2D

@export var bullet_color: Color

var story_screen = load("res://scenes/story_screen/story_screen.tscn")
var bullet_spawner = load("res://scenes/game/bullet_spawner/spawner_pinwheel.tscn")
var story_screen_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Hurtbox.player_hit.connect(_on_player_hurtbox_player_hit)
	var dialogue = Api.get_dialogue()
	story_screen_instance = story_screen.instantiate()
	story_screen_instance.lines = [dialogue.romeo_dialogue, dialogue.juliet_dialogue]
	story_screen_instance.bullet_color = Color(dialogue.color_hex_code)
	
	for i in range(3):
		place_bullet_spawner()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_hurtbox_player_hit():
	var story_screen_packed = PackedScene.new()
	story_screen_packed.pack(story_screen_instance)
	get_tree().change_scene_to_packed(story_screen_packed)

func place_bullet_spawner():
	var spawner = bullet_spawner.instantiate()
	
	spawner.max_rotation = randf_range(PI, 30 * PI)
	spawner.rotation_speed = randf_range(2 * PI, 6 * PI)
	spawner.rotate_step = randf_range(0.20, 0.55)
	spawner.spawn_velocity = randi_range(200, 600)
	spawner.bullet_color = bullet_color
	
	var viewport_size = get_viewport_rect().size
	const PADDING = 100
	const WIDTH = 150
	# xmin, xmax, ymin, ymax
	var spawn_regions = [
		[-PADDING, viewport_size[0] + PADDING, -PADDING, WIDTH],
		[-PADDING - WIDTH, -PADDING, -PADDING, viewport_size[1] / 2],
		[viewport_size[0] + PADDING, viewport_size[0] + PADDING + WIDTH, -PADDING, viewport_size[1] / 2]
	]
	var random_region = spawn_regions[randi_range(0, spawn_regions.size() - 1)]
	
	spawner.position = Vector2(randi_range(random_region[0], random_region[1]), randi_range(random_region[2], random_region[3]))
	spawner.done.connect(_on_spawner_done)
	
	$BulletNode.add_child(spawner)

func _on_spawner_done():
	place_bullet_spawner()
