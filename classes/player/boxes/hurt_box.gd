class_name HurtBox
extends Area3D

signal got_hurt(hit: HitBox)

@onready var player: Player = get_parent()
@export var ignore : HitBox

func _on_area(area: Area3D) -> void:
	if area is HitBox and area != ignore:
		var hit_box := area as HitBox
		got_hurt.emit(hit_box)

		if hit_box.damage >= 30:
			Autofuck.hit_freeze(0.5)
		else:
			Autofuck.hit_freeze(float(hit_box.damage)/100)

		if player.player_id == 1:
			Autofuck.combo_count(true)
		elif player.player_id == 2:
			Autofuck.combo_count(false)

		#if player.blocking == true:
			##hurt.stun_time = hit_box.stun_time / 2
			#if hit_box.block_damage == -1:
				#player.health -= floor(float(hit_box.damage) / 2)
			#else:
				#player.health -= hit_box.block_damage
		#else:
			#player.health -= hit_box.damage
			##hurt.stun_time = hit_box.stun_time

		player.special_bar += float(hit_box.damage) / 100
		player.other_player.special_bar += float(hit_box.damage) / 50

		if hit_box.low_hit: player.anim("low_hit")
		else: player.anim("high_hit")
		player.move_fsm._on_state_change(4)
		
