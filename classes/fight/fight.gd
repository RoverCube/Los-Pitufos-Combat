class_name Fight
extends Node3D

var player_1 : Player
var player_2 : Player
var camera: LPCCamera

@onready var animation: AnimationPlayer = $Animation
@export var char_scenes     : Array[PackedScene]
#@export var map_scenes      : Array[PackedScene]
@export var player_distance : float = 3
@export var fight_ended     : bool = false

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

	player_1.died.connect(on_player_died)
	player_2.died.connect(on_player_died)
func _ready() -> void:
	animation.play("start")

func on_player_died(dead_p: Player) -> void:
	camera.active = false
	var player: Player = dead_p.other_player
	dead_p.machine.change_state("end")
	player.machine.change_state("end")
	
	await get_tree().create_timer(0.4).timeout
	get_tree().create_tween().set_trans(Tween.TRANS_BACK).tween_property(camera,"position",
	Vector3(player.position.x, camera.position.y, 1.5), 0.2)
	animation.play("end")

func _input(event: InputEvent) -> void:
	if fight_ended == false: return
	if event.is_action_pressed("1LK"):
		$LoadingScreen.summon()
		await $LoadingScreen.got_black
		get_tree().reload_current_scene()
		
	if event.is_action_pressed("1LP"): 
		$LoadingScreen.summon()
		await $LoadingScreen.got_black
		get_tree().change_scene_to_file("res://scenes/menus/cs_menu/cs_menu.tscn")
	if event.is_action_pressed("1HP"):
		$LoadingScreen.summon()
		await $LoadingScreen.got_black 
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	


func update_hud(player_id: int, special: bool = false) -> void:
	if special == false:
		if player_id == 1:
			$"HUD/Health1/Bar".material.set_shader_parameter("value",float(player_1.health) / float(player_1.max_health))
			return
		elif player_id == 2:
			$"HUD/Health1/Bar".material.set_shader_parameter("value",float(player_2.health) / float(player_2.max_health))
			return
	else:
		if player_id == 1:
			$"HUD/Special1/Bar".material.set_shader_parameter("value",float(player_1.special_bar - floorf(player_1.special_bar)) / float(1.0))
			if player_1.special_bar >= 1:
				$"HUD/Special1/FilledBG".show()
			elif player_1.special_bar < 1:
				$"HUD/Special1/FilledBG".hide()
			$"HUD/Special1/Text".text = str(floori(player_1.special_bar))
		elif player_id == 2:
			$"HUD/Special2/Bar".material.set_shader_parameter("value",float(player_2.special_bar - floorf(player_2.special_bar)) / float(1.0))
			if player_2.special_bar >= 1:
				$"HUD/Special2/FilledBG".show()
			elif player_2.special_bar < 1:
				$"HUD/Special2/FilledBG".hide()
			$"HUD/Special2/Text".text = str(floori(player_2.special_bar))
