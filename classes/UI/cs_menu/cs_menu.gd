class_name CSMenu
extends Node2D

@export var fight_scene : PackedScene
@onready var p1_sprite  : AnimatedSprite2D = $P1Sprite
@onready var p1_sname   : Sprite2D = $P1Sprite/Name
@onready var p2_sprite  : AnimatedSprite2D = $P2Sprite
@onready var p2_sname   : Sprite2D = $P2Sprite/Name

var p1_seletion: int = 2:
	set(new):
		p1_sprite.play(str(entries[new].character))
		p1_sname.texture = entries[new].name_texture
		var tween:Tween = get_tree().create_tween().set_parallel()
		p1_sprite.modulate = Color.TRANSPARENT
		p1_sprite.position = Vector2(448.0, 604.0)
		tween.tween_property(p1_sprite,"modulate",Color.WHITE,0.2)
		tween.tween_property(p1_sprite,"position",Vector2(448.0, 540.0),0.2)
		
		
		p1_seletion = new
var p2_seletion: int = 3:
	set(new):
		p2_sprite.play(str(entries[new].character))
		p2_sname.texture = entries[new].name_texture
		var tween:Tween = get_tree().create_tween().set_parallel()
		p2_sprite.modulate = Color.TRANSPARENT
		p2_sprite.position = Vector2(1472.0, 604.0)
		tween.tween_property(p2_sprite,"modulate",Color.WHITE,0.2)
		tween.tween_property(p2_sprite,"position",Vector2(1472.0, 540.0),0.2)
		
		p2_seletion = new
var p1_confirmed: bool = false:
	set(new):
		if new == true and p1_confirmed == false:
			$P1Indicator.select()
			var c: CSEntry = entries[p1_seletion]
			c.audio_player.play_this(c.voice_lines.pick_random())
		#elif                   new == false and p1_confirmed == true:
			$P1Indicator.deselect()
			c.audio_player.play_this(c.CANCEL_SFX)
		p1_confirmed = new
var p2_confirmed: bool = false:
	set(new):
		if new == true and p2_confirmed == false:
			$P2Indicator.select()
		elif new == false and p2_confirmed == true:
			$P2Indicator.deselect()
		p2_confirmed = new
var entries: Array[CSEntry]

var tree: SceneTree

func _enter_tree() -> void:
	tree = get_tree()
	for x in get_children(false):
		if x is CSEntry:
			x.id = entries.size()
			entries.insert(entries.size(),x)

func _ready() -> void:
	$AudioPlayer.play()
	print(Autofuck.music_volume)

	p1_sprite.play(str(entries[p1_seletion].character))
	p1_sname.texture = entries[p1_seletion].name_texture
	p2_sprite.play(str(entries[p2_seletion].character))
	p2_sname.texture = entries[p2_seletion].name_texture
	p1_sprite.play(str(entries[p1_seletion].character))
	p1_sname.texture = entries[p1_seletion].name_texture
	p2_sprite.play(str(entries[p2_seletion].character))
	p2_sname.texture = entries[p2_seletion].name_texture


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
		p1_confirmed = false
	if Input.is_action_just_pressed("2HK"):
		p2_confirmed = false

	if p1_confirmed and p2_confirmed:
		go_to_map_select()

func go_to_map_select() -> void:
	await get_tree().create_timer(0.5).timeout
	$LoadingScreen.summon(false)
	Autofuck.on_loading_screen = true
	Autofuck.p1_character_id = entries[p1_seletion].character
	Autofuck.p2_character_id = entries[p2_seletion].character
	get_tree().change_scene_to_packed(fight_scene)
