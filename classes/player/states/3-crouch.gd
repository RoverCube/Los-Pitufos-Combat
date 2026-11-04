extends PlayerState

var attacking : bool = false
var no_start  : bool = false

func _on_start_state() -> void:
	if no_start == false:
		player.anim("crouch")
		await player.sprite.animation_finished
	player.col.shape = player.collision_crouched
	player.col.position.y = player.collision_crouched.size.y / 2
	player.anim("crouch idle")
	no_start = true

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

	if player.block_input == true and player.blocking == false:
		player.anim("crouch block")
		await player.sprite.animation_finished
		player.blocking = true
	if player.block_input == false and player. blocking == true:
		player.blocking = false
		player.anim("crouch idle")
