class_name CSMenu
extends Node2D

@export var fight_scene : PackedScene

var p1_seletion: int = 2
var p2_seletion: int = 5
var p1_confirmed: bool = false
var p2_confirmed: bool = false
var entries: Array[CSEntry]

var tree: SceneTree

func _enter_tree() -> void:
	tree = get_tree()
	for x in get_children(false):
		if x is CSEntry:
			x.id = entries.size()
			entries.insert(entries.size(),x)

func _process(_delta: float) -> void:
	if p1_confirmed == false:
		if Input.is_action_just_pressed("1DLeft"):  p1_seletion = entries[p1_seletion].on_left.id
		if Input.is_action_just_pressed("1DRight"): p1_seletion = entries[p1_seletion].on_right.id
		if Input.is_action_just_pressed("1DUp"):    p1_seletion = entries[p1_seletion].on_up.id
		if Input.is_action_just_pressed("1DDown"):  p1_seletion = entries[p1_seletion].on_down.id
		if $P1Deco.get_instance_shader_parameter("color") != entries[p1_seletion].color:
			$P1Deco.material.set_shader_parameter("color",entries[p1_seletion].color)
	if p2_confirmed == false:
		if Input.is_action_just_pressed("2DLeft"):  p2_seletion = entries[p2_seletion].on_left.id
		if Input.is_action_just_pressed("2DRight"): p2_seletion = entries[p2_seletion].on_right.id
		if Input.is_action_just_pressed("2DUp"):    p2_seletion = entries[p2_seletion].on_up.id
		if Input.is_action_just_pressed("2DDown"):  p2_seletion = entries[p2_seletion].on_down.id
		if $P2Deco.get_instance_shader_parameter("color") != entries[p2_seletion].color:
			$P2Deco.material.set_shader_parameter("color",entries[p2_seletion].color)

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

	if p1_confirmed and p2_confirmed:
		go_to_map_select()

func go_to_map_select() -> void:
	$LoadingScreen.summon(false)
	Autofuck.on_loading_screen = true
	Autofuck.p1_character_id = entries[p1_seletion].character
	Autofuck.p2_character_id = entries[p2_seletion].character
	get_tree().change_scene_to_packed(fight_scene)
