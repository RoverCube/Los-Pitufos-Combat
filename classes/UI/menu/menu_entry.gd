@abstract
class_name MenuEntry
extends Button

var menu : Menu

@onready var audio: AudioStreamPlayer = $Audio
@onready var anim: AnimationPlayer = $Animation
@export var confirmed_action : MenuAction

var audible : bool = true

var selected: bool = false:
	set(new):
		if selected == false and new == true:
			_on_selected()
		if selected == true and new == false:
			_on_deselected()
		selected = new

func _input(_event: InputEvent) -> void:
	if not selected:
		return
	if Input.is_action_just_pressed("UI Accept"):
		confirm()

@abstract
func confirm() -> void
func play_sfx(sfx: AudioStream) -> void:
	#if !menu.active: return
	if !audible: 
		audible = true
		return
	audio.stream = sfx
	if audio.is_inside_tree(): audio.play()

@abstract
func _on_selected() -> void
@abstract
func _on_deselected() -> void
