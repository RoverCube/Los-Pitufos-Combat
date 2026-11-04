@tool
class_name CSEntry
extends Node2D

const CANCEL_SFX = preload("uid://booh0s1cexnvj")

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
@export var voice_lines      : Array[AudioStream]

func confirm() -> void:
	if character == -2:
		get_tree().create_tween().tween_property($"../AudioPlayer","volume_db",-80.0,1.0)
		$"../LoadingScreen".summon()
		await $"../LoadingScreen".got_black
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
