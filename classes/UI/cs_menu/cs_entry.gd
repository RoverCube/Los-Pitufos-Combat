@tool
class_name CSEntry
extends Node2D

const CANCEL_SFX = preload("uid://bcrlweclgpquy")

var id               : int = -1
@onready var main    : CSMenu = get_parent()
@onready var audio_player: AudioPlayer = $AudioPlayer

@export_enum("Exit:-2","Locked:-1","Cristian","Pedro","Miguelito","Kaua",
"Heder","Kaik","Osmar","Esquilo") var character : int = -1
@export var on_left  : CSEntry
@export var on_right : CSEntry
@export var on_up    : CSEntry
@export var on_down  : CSEntry
@export var p1_indicator_pos : Vector2
@export var p2_indicator_pos : Vector2
@export var color            : Color = Color("bdc063")
@export var name_texture     : AtlasTexture
@export var confirm_voices   : Dictionary[int, AudioStream]

func confirm() -> void:
	audio_player.play_this(confirm_voices[character])
	print(confirm_voices[character])
	if character == -2:
		$"../LoadingScreen".summon()
		await $"../LoadingScreen".got_black
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")

func cancel() -> void:
	audio_player.play_this(CANCEL_SFX)
