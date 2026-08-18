class_name MainMEntry
extends MenuEntry

const SELECT_SOUND = preload("res://assets/UI/sfx/sound-8.mp3")
const CONFIRM_SOUND = preload("res://assets/UI/sfx/sound-13.mp3")

func _on_selected() -> void:
	anim.play("selected")
	play_sfx(SELECT_SOUND)

func _on_deselected() -> void:
	anim.play("deselected")

func confirm() -> void:
	if menu.active == true:
		#confirmed_action.entry = self
		confirmed_action.action()
		
		play_sfx(CONFIRM_SOUND)
