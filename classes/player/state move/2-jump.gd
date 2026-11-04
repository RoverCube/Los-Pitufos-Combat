extends PlayerState

var start_speed: float

func _start() -> void:
	player.anim("jump")
	start_speed = player.velocity.x
	player.velocity.y = player.JUMP_FORCE
	await player.sprite.animation_finished
	player.anim("jump idle")

func _physics_update(delta: float) -> void:
	#player.velocity.x += player.AIR_SPEED * delta * player.dir_inputd
	
	if player.is_on_floor() == false:
		player.velocity.y -= player.GRAVITY * delta
		player.velocity.y -= player.FALL * delta

func _checks() -> void:
	if hold_state == true: return
	
	if player.is_on_floor() == true:
		if player.dir_input != 0.0:
			change_state(1) # WALK
		if player.crouch_input == true:
			change_state(3) # CROUCH
		change_state(0) # IDLE
