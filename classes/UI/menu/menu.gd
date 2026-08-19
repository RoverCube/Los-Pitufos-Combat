class_name Menu
extends Control

@export_enum("Up Down", "Left Right") var dir: int
@export var entries : Array[MenuEntry]
var current : int = 0:
	set(new):
		current = new
		selected_changed.emit(new)
@export var active : bool = false:
	set(new):
		if new == true:
			entries[current].selected = true
		active = new

signal selected_changed(new: int)

func _ready() -> void:
	for x in entries:
		x.menu = self
	entries[0].audible = false

func _input(_event: InputEvent) -> void:
	var add_input: String
	var sub_input: String
	if dir == 0:
		add_input = "UI Down"
		sub_input = "UI Up"
	else :
		add_input = "UI Right"
		sub_input = "UI Left"
	
	if Input.is_action_just_pressed(add_input):
		change_current(1)
	if Input.is_action_just_pressed(sub_input):
		change_current(-1)

func change_current(change:int) -> void:
	if !active: return
	entries[current].selected = false
	if (current + change) < 0:
		current = (entries.size() - 1)
	elif (current + change) >= entries.size():
		current = 0
	else:
		current += change
	entries[current].selected = true
