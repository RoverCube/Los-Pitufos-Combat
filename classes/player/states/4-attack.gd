extends PlayerState

var attack_index: int
# 0 - heavy punch
# 1 - light punch
# 2 - heavy kick
# 3 - light kick
# 4 - crouch attack
# 5 - aerial attack

var anims : Array[String] = ["heavy punch","light punch","heavy kick","light kick","crouch attack","air attack"]

func _on_start_state() -> void:
	player.velocity = Vector3.ZERO
	if player.special_on:
		player.anim("#"+anims[attack_index], true)
	else: player.anim(anims[attack_index], true)
	await player.sprite.animation_finished
	change_state.emit("idle")
	# try to get attack index here if not use generic changes

func _update_physics(_delta: float) -> void: player.move_and_slide()

func _generic_change(self_state: State) -> void:
	if player.attack_input:
		if player.hp_input: attack_index = 0
		if player.lp_input: attack_index = 1
		if player.hk_input: attack_index = 2
		if player.lk_input: attack_index = 3
		
		if player.special_on == true:
			if player.special_bar < player.special_depeads[attack_index]: return
			player.special_bar -= player.special_depeads[attack_index]
		
		self_state.change_state.emit(name)
