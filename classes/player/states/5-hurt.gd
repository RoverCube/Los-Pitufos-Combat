extends PlayerState

var can_change: bool = false

func _on_start_state() -> void:
	can_change = false
	player.animation.stop()
	player.animation.play("RESET")
	await get_tree().create_timer(0.1).timeout
	can_change = true

func _update_physics(delta: float) -> void:
	if player.is_on_floor() == false:

		player.velocity.y -= delta * 32.0
		if player.velocity.y >= 0: player.velocity.y -= delta * 32.0
		player.move_and_slide()

func _check_change() -> void:
	if can_change == false: return
	print(player.is_on_floor())
	if player.is_on_floor() == false: return
	if player.dir_input:
		change_state.emit("walk")
	change_state.emit("idle")
