extends Control

@export var lines: PackedStringArray
@export var bullet_color: Color
var game = load("res://scenes/game/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$StoryText.text = "\n\n".join(lines)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var game_instance = game.instantiate()
	game_instance.bullet_color = bullet_color
	var game_packed = PackedScene.new()
	game_packed.pack(game_instance)
	get_tree().change_scene_to_packed(game_packed)
