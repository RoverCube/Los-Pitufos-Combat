extends Node

@onready var menu: Menu = $Menu

var interupt_secret : bool = false

var p1_character : int = -1
var p2_character : int = -1

func _ready() -> void:
	$Animation.play("enter")


func play_voice_line() -> void:
	$VoiceLine.play()
	interupt_secret = true
	await $VoiceLine.finished
	interupt_secret = false


func _on_selected_changed(new: int) -> void:
	var entry := menu.entries[menu.current] as CharacterSEntry
	$Menu/Character.text = entry.c_name.remove_chars(" ")
	$Menu/Character.label_settings.set_stacked_shadow_color(0, entry.color_1)
	
