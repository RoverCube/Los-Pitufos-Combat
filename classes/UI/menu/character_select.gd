extends Menu

var p1_character : int = -1
var p2_character : int = -1

func play_voice_line() -> void:
	$VoiceLine.play()


func _on_selected_changed(new: int) -> void:
	var entry := entries[new] as CharacterSEntry
	$Menu/Character.text = entry.c_name.remove_chars(" ")
	$Menu/Character.label_settings.set_stacked_shadow_color(0, entry.color_1)
	
