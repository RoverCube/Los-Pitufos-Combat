extends PlayerState

func _on_start_state() -> void:
	player.velocity = Vector3.ZERO
	player.anim("idle")

func _check_change() -> void:
	if player.dir_input != 0:
		change_state.emit("walk")
	if player.jump_input: # idle always on ground
		change_state.emit("jump")
	if player.crouch_input: # idle always on ground
		change_state.emit("crouch")
	generic_to(4) # attack
