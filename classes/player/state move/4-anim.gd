class_name PSAnim
extends PlayerState

@export var go_to_state    : int = -1
@export var stop_on_ground : bool = false
@export var stop_on_start  : bool = false

func _start() -> void:
	if stop_on_start == true:
		player.velocity = Vector3.ZERO
	hold_state = true
	await player.sprite.animation_finished
	if go_to_state != -1:
		change_state(go_to_state)
	hold_state = false

func _end() -> void:
	stop_on_ground = false
	stop_on_start  = false
	go_to_state = -1

func _physics_update(delta: float) -> void:
	if player.is_on_floor() == false:
		player.velocity.y -= player.GRAVITY * delta
		player.velocity.y -= player.FALL * delta
	if player.is_on_floor() == true and stop_on_ground == true:
		player.velocity = Vector3.ZERO

func _checks() -> void:
	if hold_state == true: return

	if player.crouch_input == true:
		change_state(3) # CROUCH
	if player.jump_input == true:
		change_state(2) # JUMP
	if player.dir_input != 0.0:
		change_state(1) # WALK
	if player.is_on_floor() == true:
		change_state(0) # IDLE
