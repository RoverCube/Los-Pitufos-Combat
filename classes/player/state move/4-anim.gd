class_name PSAnim
extends PlayerState

@export var go_to_state: int = -1

func _start() -> void:
	hold_state = true
	await player.sprite.animation_finished
	hold_state = false

func _physics_update(delta: float) -> void:
	if player.is_on_floor() == false:
		player.velocity.y -= player.GRAVITY * delta
		player.velocity.y -= player.FALL * delta

func _checks() -> void:
	if hold_state == true: return

	if go_to_state != -1:
		change_state(go_to_state)
	if player.crouch_input == true:
		change_state(3) # WALK
	if player.jump_input == true:
		change_state(2) # WALK
	if player.dir_input != 0.0:
		change_state(1) # WALK
	change_state(0) # IDLE	
