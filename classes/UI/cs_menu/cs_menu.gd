class_name CSMenu
extends Node2D

var p1_seletion: int = 0
var p2_seletion: int = 7
var entries: Array[CSEntry]

func _enter_tree() -> void:
	for x in get_children(false):
		if x is CSEntry:
			x.id = entries.size()
			entries.insert(entries.size(),x)

func _input(_event: InputEvent) -> void:
	var p1_input = Input.get_vector("1DLeft","1DRight","1DUp","1DDown") # Dpad
	var p2_input = Input.get_vector("2DLeft","2DRight","2DUp","2DDown") # Dpad
	if p1_input == Vector2.ZERO and p2_input == Vector2.ZERO: return
	
	if p1_input == Vector2.UP: p1_seletion    = entries[p1_seletion].on_up.id
	if p1_input == Vector2.DOWN: p1_seletion  = entries[p1_seletion].on_down.id
	if p1_input == Vector2.LEFT: p1_seletion  = entries[p1_seletion].on_left.id
	if p1_input == Vector2.RIGHT: p1_seletion = entries[p1_seletion].on_right.id
	
	if p2_input == Vector2.UP: p2_seletion    = entries[p2_seletion].on_up.id
	if p2_input == Vector2.DOWN: p2_seletion  = entries[p2_seletion].on_down.id
	if p2_input == Vector2.LEFT: p2_seletion  = entries[p2_seletion].on_left.id
	if p2_input == Vector2.RIGHT: p2_seletion = entries[p2_seletion].on_right.id
	
	
	print(p1_seletion)
