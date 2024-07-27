extends Node

const SAMPLE_DATA = "res://scripts/api/sample_data.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_dialogue():
	var sample_data_text = FileAccess.get_file_as_string(SAMPLE_DATA)
	var sample_data_array = JSON.parse_string(sample_data_text)
	return sample_data_array[randi_range(0, sample_data_array.size() - 1)]
