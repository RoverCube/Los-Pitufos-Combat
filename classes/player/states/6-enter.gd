extends PlayerState

func _on_start_state() -> void:
	await get_tree().create_timer(1.0).timeout
	change_state.emit("idle")
