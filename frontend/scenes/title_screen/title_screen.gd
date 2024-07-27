extends Control

var story_screen = load("res://scenes/story_screen/story_screen.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Api.get_dialogue()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var story_screen_instance = story_screen.instantiate()
	
	var dialogue = Api.data
	if (not dialogue.has("romeo_dialogue") or not dialogue.has("juliet_dialogue")):
		dialogue = Api.get_fallback_dialogue()
	story_screen_instance.lines = [dialogue.romeo_dialogue, dialogue.juliet_dialogue]
	if (not dialogue.has("color_hex_code")):
		dialogue = Api.get_fallback_dialogue()
	story_screen_instance.bullet_color = Color(dialogue.color_hex_code)
	var story_screen_packed = PackedScene.new()
	story_screen_packed.pack(story_screen_instance)
	get_tree().change_scene_to_packed(story_screen_packed)
