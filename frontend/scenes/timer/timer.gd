extends Control

@export var value: float
@export var value_max: float

signal done

const BAR_WIDTH = 1076

# Called when the node enters the scene tree for the first time.
func _ready():
	value = value_max


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value -= delta
	$Bar.size[0] = BAR_WIDTH * value / value_max
	if value <= 0:
		done.emit()
