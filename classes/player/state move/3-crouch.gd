extends PlayerState

func _start() -> void:
	player.velocity = Vector3.ZERO
	if not (fsm.previous is PSAnim):
		player.anim("crouch")
		await player.sprite.animation_finished
	player.anim("crouch idle")
	player.col.shape = player.col_crouch
	player.col.position.y = player.col_crouch.size.y / 2

func _end() -> void:
	player.anim("uncrouch")
	player.col.shape = player.col_stand
	player.col.position.y = player.col_stand.size.y / 2

func _physics_update(_delta: float) -> void:
	player.turn()

func _checks() -> void:
	if hold_state == true: return

	if player.crouch_input == false:
		if player.dir_input != 0.0:
			change_state(1) # WALK
		if player.jump_input == true:
			change_state(2) # JUMP
		change_state(0) # IDLE
