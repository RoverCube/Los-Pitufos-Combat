extends AttackState

@onready var anim: PSAnim = $"../../MovementFSM/Anim"
const ATTACK_NAMES: Array[String] = ["light punch","heavy punch",
"light kick","heavy kick","special light punch",
"special heavy punch","special light kick",
"special heavy kick","crouch attack","jump attack"]
@onready var f_datas: Array[FrameData] = [player.lp ,player.hp,
player.lk, player.hk, player.slp ,player.shp, player.slk, player.shk,
player.ca,player.aa]


func _start() -> void:
	if fsm.previous is ASNeutral:
		print(ATTACK_NAMES[fsm.previous.attack_type])
		player.anim(ATTACK_NAMES[fsm.previous.attack_type])
		player.activate_fdata(f_datas[fsm.previous.attack_type])
		move_fsm._on_state_change(4) # ANIM
		
		await player.sprite.animation_finished
		
		change_state(0)
