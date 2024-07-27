extends HTTPRequest

const SAMPLE_DATA = "res://scripts/api/sample_data.json"
const URL_DIALOGUE_POSITIVE = "http://localhost:5000/positiveStory"
const URL_DIALOGUE_NEGATIVE = "http://localhost:5000/negativeStory"
var data

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_positive_dialogue():
	print("request made")
	data = null
	request(URL_DIALOGUE_POSITIVE)
	
func get_negative_dialogue():
	print("request made")
	data = null
	request(URL_DIALOGUE_NEGATIVE)

func get_fallback_dialogue():
	var sample_data_text = FileAccess.get_file_as_string(SAMPLE_DATA)
	var sample_data_array = JSON.parse_string(sample_data_text)
	return sample_data_array[randi_range(0, sample_data_array.size() - 1)]

func _on_request_completed(result, response_code, headers, body):
	print("request resolved")
	var json = JSON.parse_string(body.get_string_from_utf8())
	if json.has("dialogue_response"):
		data = JSON.parse_string(json.dialogue_response)
	else:
		data = json
	print(data, typeof(data))
