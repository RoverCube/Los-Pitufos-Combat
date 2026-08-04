extends PlayerState

const GRAVITY: int = 20
const FALL:    int = 20

func _on_start_state() -> void:
	player.velocity.y = player.jump

func _update_physics(delta: float) -> void:
	player.velocity.y -= delta * GRAVITY
	if player.velocity.y >= 0: player.velocity.y -= delta * FALL
	player.move_and_slide()

func _check_change() -> void:
	if player.is_on_floor():
		if player.dir_input: change_state.emit("walk")
		change_state.emit("idle")
