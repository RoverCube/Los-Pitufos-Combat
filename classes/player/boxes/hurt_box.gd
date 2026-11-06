class_name HurtBox
extends Area3D

signal got_hurt(hit: HitBox)

@onready var audio_player: AudioPlayer = $AudioPlayer
@onready var player: Player = get_parent()
@export  var ignore : HitBox
@onready var defense: AttackState = $"../AttackFSM/Defense"

func _on_area(area: Area3D) -> void:
	if area is HitBox and area != ignore:
		var hit_box := area as HitBox

		got_hurt.emit(hit_box)
		var damage_delt: int
		var stun_taken : float

		if hit_box.damage >= 30:
			Autofuck.hit_freeze(0.5)
		else:
			Autofuck.hit_freeze(float(hit_box.damage)/100)

		if player.player_id == 1:
			Autofuck.combo_count(true)
		elif player.player_id == 2:
			Autofuck.combo_count(false)

		if player.atk_fsm.current == defense:
			stun_taken  = hit_box.stun_time / 2
			if hit_box.block_damage == -1:
				damage_delt = floor(float(hit_box.damage) / 2)
			else:
				damage_delt = hit_box.block_damage
		else:
			damage_delt = hit_box.damage
			stun_taken = hit_box.stun_time

		if hit_box.sfx_type == 0:
			audio_player.play_this(hit_box.SFX_HIT[randi_range(0,2)])
		else:
			audio_player.play_this(hit_box.SWORD_SWING)
		audio_player.pitch_scale = randf_range(0.9,1.1)

		player.health -= damage_delt
		player.special_bar += 0.03 * float(damage_delt)
		player.other_player.special_bar += 0.03 * float(damage_delt) * 1.5

		if hit_box.low_hit: player.sprite.play("low_hit", (float(player.high_hit_duration) / 12.0) * stun_taken)
		else: player.sprite.play("high_hit", 1.0/3.0 / stun_taken)
		print((float(player.high_hit_duration) / 12.0) * (stun_taken))
		player.move_fsm._on_state_change(4)
		player.anim_state.go_to_state = -1
		player.anim_state.stop_on_ground = true
