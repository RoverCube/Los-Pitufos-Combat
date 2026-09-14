extends PlayerState

@export var attack_state : PlayerState
@export var crouch_col   : BoxShape3D
var standing_col         : BoxShape3D

func _on_start_state() -> void:
	standing_col = player.col.shape
	
	player.anim("crouch")
	player.col.shape = crouch_col
	player.col.position.y = crouch_col.size.y / 2

func _on_end_state() -> void:
	player.anim("uncrouch")
	player.col.shape = standing_col
	player.col.position.y = standing_col.size.y / 2
	

func _check_change() -> void:
	if player.crouch_input == false:
		change_state.emit("idle")
	if player.attack_input:
		attack_state.attack_index = 4
		change_state.emit("attack")
