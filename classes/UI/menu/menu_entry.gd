class_name MenuEntry
extends Button

var menu : Menu

@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
@onready var anim: AnimationPlayer = $Animation
@export var confirmed_action : MenuAction

var audible : bool = true
const SELECT_SOUND = preload("res://assets/UI/sfx/sound-8.mp3")
const CONFIRM_SOUND = preload("res://assets/UI/sfx/sound-13.mp3")

var selected: bool = false:
	set(new):
		if selected == false and new == true:
			anim.play("selected")
			play_sfx(SELECT_SOUND)
		if selected == true and new == false:
			anim.play("deselected")
		selected = new

func _input(_event: InputEvent) -> void:
	if not selected:
		return
	
	if Input.is_action_just_pressed("UI Accept"):
		confirm()

func confirm() -> void:
	if menu.active == true:
		#confirmed_action.entry = self
		confirmed_action.action()
		
		play_sfx(CONFIRM_SOUND)

func play_sfx(sfx: AudioStream) -> void:
	#if !menu.active: return
	if !audible: 
		audible = true
		return
	audio.stream = sfx
	audio.play()
	print(name)
