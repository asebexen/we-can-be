extends Control

@export var lines: PackedStringArray
var game = load("res://scenes/game/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$StoryText.text = "\n\n".join(lines)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_packed(game)
