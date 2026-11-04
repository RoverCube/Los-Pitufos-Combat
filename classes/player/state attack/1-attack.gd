extends AttackState

const ATTACK_NAMES: Array[String] = ["light punch","heavy punch",
"light kick","heavy kick","crouch","jump attack"]

func _start() -> void:
	if fsm.previous is ASNeutral:
		player.anim(ATTACK_NAMES[fsm.previous.attack_type])
		move_fsm._on_state_change(4) # ANIM
		await player.sprite.animation_finisheds
		change_state(0)
