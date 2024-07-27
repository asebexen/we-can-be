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
	
	place_bullet_spawners()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_player_hurtbox_player_hit():
	var story_screen_packed = PackedScene.new()
	story_screen_packed.pack(story_screen_instance)
	get_tree().change_scene_to_packed(story_screen_packed)

func place_bullet_spawners():
	var spawner1 = bullet_spawner.instantiate()
	var spawner2 = bullet_spawner.instantiate()
	var spawner3 = bullet_spawner.instantiate()
	
	spawner1.max_rotation = 31.416
	spawner1.rotation_speed = 6
	spawner1.rotate_step = .063
	spawner1.spawn_velocity = 300
	spawner1.bullet_color = bullet_color
	spawner1.position = Vector2(150, 82)
	
	spawner2.max_rotation = 15.708
	spawner2.rotation_speed = 3
	spawner2.rotate_step = 0.252
	spawner2.spawn_velocity = 500
	spawner2.bullet_color = bullet_color
	spawner2.position = Vector2(1064, 78)
	
	spawner3.max_rotation = 11.472
	spawner3.rotation_speed = 5
	spawner3.rotate_step = 0.084
	spawner3.spawn_velocity = 150
	spawner3.bullet_color = bullet_color
	spawner3.position = Vector2(624, 182)
	
	add_child(spawner1)
	add_child(spawner2)
	add_child(spawner3)
