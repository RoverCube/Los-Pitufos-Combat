class_name Fight
extends Node3D

var player_1 : Player
var player_2 : Player
var camera: LPCCamera

@export var char_scenes     : Array[PackedScene]
#@export var map_scenes      : Array[PackedScene]
@export var player_distance : float = 3

func _enter_tree() -> void:
	player_1 = char_scenes[Autofuck.p1_character_id].instantiate()
	player_2 = char_scenes[Autofuck.p2_character_id].instantiate()

	player_1.position.x = -player_distance
	player_2.position.x =  player_distance

	player_1.other_player = player_2
	player_2.other_player = player_1
	player_2.player_id = 2

	camera = get_child(0)
	camera.p1 = player_1
	camera.p2 = player_2

	add_child(player_1)
	add_child(player_2)
