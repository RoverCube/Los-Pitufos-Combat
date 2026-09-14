extends PlayerState

# This guy is gonna become the windup to the jump
# there is gonna be an AirBorn state and that state
# is the one that will do the gravity
# And its gonna thansition to the AirAttack state

const GRAVITY   : float = 32.0
const FALL      : float = 32.0
var start_speed : float = 0.0

func _on_start_state() -> void:
	player.anim("jump")
	player.velocity.y += player.jump
	start_speed = player.velocity.x
	await player.sprite.animation_finished
	player.anim("air")

func _update_physics(delta: float) -> void:
	# air movement
	player.velocity.x = player.air_speed * delta * player.dir_input + start_speed
	
	player.velocity.y -= delta * GRAVITY
	if player.velocity.y >= 0: player.velocity.y -= delta * FALL
	player.move_and_slide()

func _check_change() -> void:
	if player.is_on_floor():
		if player.dir_input: change_state.emit("walk")
		change_state.emit("idle")
