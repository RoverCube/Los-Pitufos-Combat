extends PlayerState

func _on_start_state() -> void:
	pass # animations

func _update_physics(delta: float) -> void:
	player.velocity.x = player.speed * delta * player.dir_input
	player.move_and_slide()

func _on_end_state() -> void:
	player.velocity.x = 0

func _check_change() -> void:
	if player.dir_input == 0: change_state.emit("idle")
	if player.jump_input: change_state.emit("jump")
	if player.attack_input: change_state.emit("attack")
