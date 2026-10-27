extends PlayerState

var attacking : bool = false

func _on_start_state() -> void:
	player.anim("crouch")
	player.col.shape = player.collision_crouched
	player.col.position.y = player.collision_crouched.size.y / 2
	await player.sprite.animation_finished
	player.anim("crouch idle")

func _on_end_state() -> void:
	player.anim("uncrouch")
	player.col.shape = player.collision_shape
	player.col.position.y = player.collision_shape.size.y / 2

func _check_change() -> void:
	if player.crouch_input == false and attacking == false:
		change_state.emit("idle")

	if player.attack_input == true and attacking == false:
		attacking = true
		player.anim("crouch attack", true)
		await player.sprite.animation_finished
		player.anim("crouch idle")
		attacking = false
