extends PlayerState

var forwards: bool = true

func _start() -> void:
	## WIP
	#if player.dir_input > 0: 
		#forwards = true
		#player.anim("walk ward")
	#else: 
		#forwards = false
		#player.anim("walk forward")
	player.anim("walk")

func _physics_update(delta: float) -> void:
	player.velocity.x = player.dir_input * player.WALK_SPEED * delta
	player.turn()

func _checks() -> void:
	if hold_state == true: return

	if is_zero_approx(player.dir_input):
		change_state(0) # IDLE
	if player.jump_input == true:
		change_state(2) # JUMP
	if player.crouch_input == true:
		change_state(3) # CROUCH
