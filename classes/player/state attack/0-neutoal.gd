class_name ASNeutral
extends AttackState

@export var move_crouch_state : PlayerState
@export var move_jump_state   : PlayerState
@export var move_anim_state   : PSAnim
var attack_type: int = -1


func _checks() -> void:
	if player.attack_input == true:
		if move_fsm.current == move_crouch_state:
			attack_type = 8
			move_crouch_state.do_end = false
			move_anim_state.go_to_state = 3
			change_state(1)
		if move_fsm.current == move_jump_state:
			attack_type = 9
			move_anim_state.stop_on_ground = true
			move_anim_state.go_to_state = -1
			change_state(1)
		
		if player.is_on_floor() == true:
			move_anim_state.stop_on_start = true
			if player.lp_input == true: attack_type = 0
			if player.hp_input == true: attack_type = 1
			if player.lk_input == true: attack_type = 2
			if player.hk_input == true: attack_type = 3
#			if player.special_onoff == true: 
#				attack_type += 4
			change_state(1)
		
