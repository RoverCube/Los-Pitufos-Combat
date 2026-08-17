class_name Menu
extends Control

@export var entries : Array[MenuEntry]
var current : int = 0
@export var active : bool = false:
	set(new):
		if new == true:
			entries[current].selected = true
		#visible = new
		active = new


func _ready() -> void:
	for x in entries:
		x.menu = self
	entries[0].audible = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("UI Down"):
		change_current(1)
	if Input.is_action_just_pressed("UI Up"):
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
