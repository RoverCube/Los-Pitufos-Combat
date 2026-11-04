class_name ASNeutral
extends AttackState

@export var move_crouch_state : PlayerState
@export var move_jump_state   : PlayerState
var attack_type: int = -1


func _checks() -> void:
	if player.attack_input == true:
		if fsm.current == move_crouch_state:
			change_state(1)
			attack_type = 4
		if fsm.current == move_jump_state:
			attack_type = 5
			change_state(1)

		if player.lp_input == true: attack_type = 0
		if player.hp_input == true: attack_type = 0
		if player.lk_input == true: attack_type = 0
		if player.hk_input == true: attack_type = 0
		change_state(1)
		
