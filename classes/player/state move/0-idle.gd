extends PlayerState

func _start() -> void:
	player.anim("idle")
	player.velocity = Vector3.ZERO

func _physics_update(_delta: float) -> void:
	player.turn()

func _checks() -> void:
	if hold_state == true: return

	if player.dir_input != 0.0:
		change_state(1) # WALK
	if player.jump_input == true:
		change_state(2) # JUMP
	if player.crouch_input == true:
		change_state(3) # CROUCH
