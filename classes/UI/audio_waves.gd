class_name MusicWaves
extends Node2D

@export var color: Color
var heights : Array[float]

@export var count: int = 16

const FREQ_MAX = 11050.0

const HEIGHT = 1
const HEIGHT_SCALE = 16
const MIN_DB = 60
const ANIMATION_SPEED = 0.1

var spectrum
var min_values = []
var max_values = []


func _draw():
	@warning_ignore("integer_division")
	for i in range(count):
		var min_height = min_values[i]
		var max_height = max_values[i]
		var height = lerp(min_height, max_height, ANIMATION_SPEED)
		heights.insert(i,height)



func _process(_delta):
	var data = []
	var prev_hz = 0

	for i in range(1, count + 1):
		var hz = i * FREQ_MAX / count
		var magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clampf((MIN_DB + linear_to_db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * HEIGHT * HEIGHT_SCALE
		data.append(height)
		prev_hz = hz

	for i in range(count):
		if data[i] > max_values[i]:
			max_values[i] = data[i]
		else:
			max_values[i] = lerp(max_values[i], data[i], ANIMATION_SPEED)

		if data[i] <= 0.0:
			min_values[i] = lerp(min_values[i], 0.0, ANIMATION_SPEED)

	# Sound plays back continuously, so the graph needs to be updated every frame.
	queue_redraw()


func _ready():
	spectrum = AudioServer.get_bus_effect_instance(0, 0)
	min_values.resize(count)
	max_values.resize(count)
	min_values.fill(0.0)
	max_values.fill(0.0)
