class_name CSMenu
extends Node2D

var p1_seletion: int = 2
var p2_seletion: int = 5
var p1_confirmed: bool = false
var p2_confirmed: bool = false
var entries: Array[CSEntry]

func _enter_tree() -> void:
	for x in get_children(false):
		if x is CSEntry:
			x.id = entries.size()
			entries.insert(entries.size(),x)

func _input(event: InputEvent) -> void:
	if event.is_echo(): return
	if event is InputEventMouse: return
	var p1_input = Input.get_vector("1DLeft","1DRight","1DUp","1DDown") # Dpad
	var p2_input = Input.get_vector("2DLeft","2DRight","2DUp","2DDown") # Dpad
	if p1_confirmed == false:
		if p1_input == Vector2.UP: p1_seletion    = entries[p1_seletion].on_up.id
		if p1_input == Vector2.DOWN: p1_seletion  = entries[p1_seletion].on_down.id
		if p1_input == Vector2.LEFT: p1_seletion  = entries[p1_seletion].on_left.id
		if p1_input == Vector2.RIGHT: p1_seletion = entries[p1_seletion].on_right.id
	if p2_confirmed == false:
		if p2_input == Vector2.UP: p2_seletion    = entries[p2_seletion].on_up.id
		if p2_input == Vector2.DOWN: p2_seletion  = entries[p2_seletion].on_down.id
		if p2_input == Vector2.LEFT: p2_seletion  = entries[p2_seletion].on_left.id
		if p2_input == Vector2.RIGHT: p2_seletion = entries[p2_seletion].on_right.id
	if Input.is_action_just_pressed("1LK"):
		entries[p1_seletion].confirm()
		if entries[p1_seletion].character != -1: p1_confirmed = true
	if Input.is_action_just_pressed("2LK"):
		entries[p2_seletion].confirm()
		if entries[p2_seletion].character != -1: p2_confirmed = true
	if Input.is_action_just_pressed("1HK"):
		entries[p1_seletion].cancel()
		p1_confirmed = false
	if Input.is_action_just_pressed("2HK"):
		entries[p2_seletion].cancel()
		p2_confirmed = false
	
	print(p1_confirmed,p2_confirmed)
	if p1_confirmed and p2_confirmed:
		go_to_map_select()

func go_to_map_select() -> void:
	$LoadingScreen.summon()
	Autofuck.p1_character_id = p1_seletion
	Autofuck.p2_character_id = p2_seletion
	await $LoadingScreen.got_black
	breakpoint
