@tool
class_name CSEntry
extends Node2D

var id               : int = -1
@onready var main    : CSMenu = get_parent()
@onready var sprite  : AnimatedSprite2D = $Sprite
@onready var border  : AnimatedSprite2D = $BorderSprite
@onready var audio_player: AudioPlayer = $AudioPlayer


@export_enum("Locked:-1","Cristian","Pedro","Miguelito","Kaua",
"Heder","Kaik","Osmar","Esquilo") var character : int = -1
@export var on_left  : CSEntry
@export var on_right : CSEntry
@export var on_up    : CSEntry
@export var on_down  : CSEntry
@export var frames   : SpriteFrames
@export var confirm_voices: Dictionary[int, AudioStream]

func _ready() -> void:
	if frames != null: sprite.sprite_frames = frames
	sprite.play("unselected")

func got_selected(p2: bool) -> void:
	sprite.play("selected")
	if p2 == true:
		border.play("p2")
		return
	border.play("p1")
	return

func confirm() -> void:
	audio_player.play_this(confirm_voices[character])
	print(confirm_voices[character])
