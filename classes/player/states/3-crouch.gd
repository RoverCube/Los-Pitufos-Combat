extends PlayerState



func _check_change() -> void:
	if player.crouch_input == false:
		change_state.emit("idle")
