extends PlayerState

func _on_start_state() -> void:
	player.anim("block start",true,true)
	await  player.animation.animation_finished
	player.blocking = true
	print("ssssssssssssssssssssssssssssssssss")
	#player.anim("block idle")

func _on_end_state() -> void:
	player.sprite.modulate = Color.WHITE
	player.blocking = false

func _check_change() -> void:
	if player.block_input == false:
		change_state.emit("idle")

func _generic_change(self_state: State) -> void:
	if player.block_input == true:
		self_state.change_state.emit(name)
