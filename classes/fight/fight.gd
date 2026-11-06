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
var p1_confirm : bool = false:
	set(new):
		if new == true:
			p1_confirm = new
			get_tree().create_tween().tween_property($Continue/Label/Confirm1,"modulate",Color.WHITE,0.2)
var p2_confirm : bool = false:
	set(new):
		if new == true:
			p2_confirm = new
			get_tree().create_tween().tween_property($Continue/Label/Confirm2,"modulate",Color.WHITE,0.2)
var walkie: AudioPlayer
var rounds_won_p1: int = 0:
	set(new):
		if new == 1:
			$HUD/Health1/Won1.show()
		if new == 2:
			$HUD/Health1/Won2.show()
		rounds_won_p1 = new
var rounds_won_p2: int = 0:
	set(new):
		if new == 1:
			$HUD/Health2/Won1.show()
		if new == 2:
			$HUD/Health2/Won2.show()
		rounds_won_p2 = new

var musics: Array[AudioStream] = [FIGHT_1,FIGHT_2,FIGHT_3,FIGHT_4,FIGHT_5]
const FIGHT_1 = preload("uid://dkq76pqrsiwip")
const FIGHT_2 = preload("uid://bwawvy828ik46")
const FIGHT_3 = preload("uid://c218484stkkkr")
const FIGHT_4 = preload("uid://qs5gy80ptk2i")
const FIGHT_5 = preload("uid://3r16lykpyaed")

const NARRA : Array[AudioStream] = [NARRA_2,NARRA_3,NARRA_4]
const NARRA_1 = preload("uid://d3j3dcb84age8")
const NARRA_2 = preload("uid://bajjp55h3yx1x")
const NARRA_3 = preload("uid://5eqqkvh3ekma")
const NARRA_4 = preload("uid://6h7rekf16v8u")

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
	var audio_player: AudioPlayer = AudioPlayer.new()
	if Autofuck.get_children().is_empty():
		Autofuck.add_child(audio_player)
		musics.shuffle()
		audio_player.play_this(musics.front())
		musics.push_back(musics.front())
	else:
		audio_player = Autofuck.get_child(0)
	audio_player.finished.connect(_on_audio_player_finished)
	audio_player.volume_db -= 15

	animation.play("walkie up")
	await animation.animation_finished
	animation.play("walkie idle")
	walkie = AudioPlayer.new()
	walkie.type = 2
	add_child(walkie)
	walkie.play_this(NARRA.pick_random())

	await walkie.finished
	animation.play("walkie down")
	player_1.audio.play_this(player_1.enter_voicelines.pick_random())
	await player_1.audio.finished
	player_2.audio.play_this(player_2.enter_voicelines.pick_random())
	await player_2.audio.finished

	get_tree().create_tween().tween_property(audio_player,"volume_db",audio_player.volume_db + 15 ,0.5)
	animation.play("start")
	walkie.queue_free()
	
	update_hud(1,false)
	update_hud(1,true)
	update_hud(2,false)
	update_hud(2,true)
	


func on_player_died(dead_p: Player) -> void:
	# END GAME STUFF
	if rounds_won_p1 == 1 or rounds_won_p2 == 1:
		
		camera.active = false
		var player: Player = dead_p.other_player
		await player.move_fsm.changed_state
		
		if dead_p.player_id == 1:
			rounds_won_p2 += 1
		else: rounds_won_p1 += 1
		
		dead_p.anim("crouch")
		dead_p.anim_state.stop_on_ground = true
		dead_p.anim_state.stop_on_start  = true
		dead_p.move_fsm._on_state_change(4) # ANIM
		dead_p.atk_fsm.process_mode = Node.PROCESS_MODE_DISABLED
		dead_p.move_fsm.process_mode = Node.PROCESS_MODE_DISABLED

		player.anim("idle")
		player.anim_state.stop_on_ground = true
		player.anim_state.stop_on_start = true
		player.move_fsm._on_state_change(4) # ANIM
		player.atk_fsm.process_mode = Node.PROCESS_MODE_DISABLED
		player.move_fsm.process_mode = Node.PROCESS_MODE_DISABLED

		if player.player_id == 1:
			$VictoryCard/P1.show()
		else: $VictoryCard/P2.show()

		await get_tree().create_timer(0.4).timeout
		get_tree().create_tween().set_trans(Tween.TRANS_BACK).tween_property(camera,"position",
		Vector3(player.position.x, 1.3, 1.5), 0.2)
		animation.play("end")
	else:
		
		
		var player: Player = dead_p.other_player
		await player.move_fsm.changed_state
		
		dead_p.anim("crouch")
		dead_p.anim_state.stop_on_ground = true
		dead_p.anim_state.stop_on_start  = true
		dead_p.move_fsm._on_state_change(4) # ANIM
		dead_p.atk_fsm.process_mode = Node.PROCESS_MODE_DISABLED
		dead_p.move_fsm.process_mode = Node.PROCESS_MODE_DISABLED

		player.anim("idle")
		player.anim_state.stop_on_ground = true
		player.anim_state.stop_on_start = true
		player.move_fsm._on_state_change(4) # ANIM
		player.atk_fsm.process_mode = Node.PROCESS_MODE_DISABLED
		player.move_fsm.process_mode = Node.PROCESS_MODE_DISABLED

		if rounds_won_p1 == 1 and rounds_won_p2 == 2:
			animation.play("final round")
		else: animation.play("round 2")
			
		await animation.animation_finished
		dead_p.anim("uncrouch")
		await dead_p.sprite.animation_finished
		dead_p.anim("idle")
		
		if dead_p.player_id == 1:
			rounds_won_p2 += 1
		else: rounds_won_p1 += 1
		
		dead_p.health = dead_p.max_health
		player.health = player.max_health
		update_hud(1,false)
		update_hud(1,true)
		update_hud(2,false)
		update_hud(2,true)
		
		dead_p.move_fsm._on_state_change(0) # ANIM
		player.move_fsm._on_state_change(0) # ANIM

		# got back
		dead_p.atk_fsm.process_mode = Node.PROCESS_MODE_INHERIT
		dead_p.move_fsm.process_mode = Node.PROCESS_MODE_INHERIT
		player.atk_fsm.process_mode = Node.PROCESS_MODE_INHERIT
		player.move_fsm.process_mode = Node.PROCESS_MODE_INHERIT

func _input(_event: InputEvent) -> void:
	if fight_ended == false: return
	p1_confirm = player_1.dir_input or player_1.jump_input or player_1.crouch_input or player_1.block_input or Input.is_action_just_pressed("1LP") or Input.is_action_just_pressed("1HP") or Input.is_action_just_pressed("1LK") or Input.is_action_just_pressed("1HK") or Input.is_action_just_pressed("1#")
	p2_confirm = player_2.dir_input or player_2.jump_input or player_2.crouch_input or player_2.block_input or Input.is_action_just_pressed("2LP") or Input.is_action_just_pressed("2HP") or Input.is_action_just_pressed("2LK") or Input.is_action_just_pressed("2HK") or Input.is_action_just_pressed("2#")
	
	if p1_confirm and p2_confirm:
		
		$ColorRect.show()
		$ColorRect.modulate = Color.TRANSPARENT
		get_tree().create_tween().tween_property($ColorRect,"modulate",Color.WHITE,0.2)
		await get_tree().create_timer(0.2).timeout
		get_tree().reload_current_scene()

func update_hud(player_id: int, special: bool = false) -> void:
	if special == false:
		if player_id == 1:
			$"HUD/Health1/Bar".material.set_shader_parameter("value",float(player_1.health) / float(player_1.max_health))
			return
		elif player_id == 2:
			$"HUD/Health2/Bar".material.set_shader_parameter("value",float(player_2.health) / float(player_2.max_health))
			return
	else:
		if player_id == 1:
			$"HUD/Special1/Bar".material.set_shader_parameter("value",float(player_1.special_bar - floorf(player_1.special_bar)) / float(1.0))
			if player_1.special_bar >= 1:
				$"HUD/Special1/FilledBG".show()
			elif player_1.special_bar < 1:
				$"HUD/Special1/FilledBG".hide()
			if player_1.special_bar == player_1.special_bar_max:
				$HUD/Special1/FilledBG2.show()
				$HUD/Special1/Effect.emitting = true
				$HUD/Special1/Effect2.show()
			else:
				$HUD/Special1/FilledBG2.hide()
				$HUD/Special1/Effect.emitting = false
				$HUD/Special1/Effect2.hide()
			$"HUD/Special1/Text".text = str(floori(player_1.special_bar))
		elif player_id == 2:
			$"HUD/Special2/Bar".material.set_shader_parameter("value",float(player_2.special_bar - floorf(player_2.special_bar)) / float(1.0))
			if player_2.special_bar >= 1:
				$"HUD/Special2/FilledBG".show()
			elif player_2.special_bar < 1:
				$"HUD/Special2/FilledBG".hide()
			if player_2.special_bar == player_2.special_bar_max:
				$HUD/Special2/FilledBG2.show()
				$HUD/Special2/Effect.emitting = true
				$HUD/Special2/Effect2.show()
			else:
				$HUD/Special2/FilledBG2.hide()
				$HUD/Special2/Effect.emitting = false
				$HUD/Special2/Effect2.hide()
			$"HUD/Special2/Text".text = str(floori(player_2.special_bar))

func _on_audio_player_finished() -> void:
	Autofuck.get_child(0).play_this(musics.front())
	musics.push_back(musics.front())
