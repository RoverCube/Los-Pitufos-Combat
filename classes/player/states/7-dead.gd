extends PlayerState

func _on_start_state() -> void:
	await get_tree().create_timer(0.2).timeout
	if player.health == 0:
		player.anim("crouch")
	else:
		player.anim("idle")
