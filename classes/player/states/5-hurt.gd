extends PlayerState

var from_crouch : bool  = false
var can_change  : bool  = false
var stun_time   : float = 0

func _on_start_state() -> void:
	can_change = false
	$"../../HitBox/HitCol".disabled = true
	#player.anim("RESET",true,true)
	player.sprite.modulate = Color.RED
	await get_tree().create_timer(stun_time).timeout
	get_tree().create_tween().tween_property(player.sprite,"modulate", Color.WHITE, 0.1)
	can_change = true

func _update_physics(delta: float) -> void:
	if player.is_on_floor() == false:
		player.velocity.y -= delta * 32.0
		if player.velocity.y >= 0: player.velocity.y -= delta * 32.0
		player.move_and_slide()

func _check_change() -> void:
	if can_change == false: return
	if player.is_on_floor() == false: return
	if from_crouch == true:
		$"../Crouch".no_start = true
		change_state.emit("crouch")
		return
	if player.dir_input:
		change_state.emit("walk")
		return
	change_state.emit("idle")
