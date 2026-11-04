class_name HitBox
extends Area3D

@export_range(-1,500) var damage       : int = 25
@export_range(-1,500) var block_damage : int = -1
@export_range(0.25,3) var stun_time    : float = 0.25
@export_range(0,10)   var knockback    : float = 0.0
@export               var low_hit      : bool = false
@export_enum("Punch:0","Slash:1")
var sfx_type     : int = 0
const SFX : Array[AudioStream] = []

func _on_area_entered(area: Area3D) -> void:
	if area is HitBox:
		Autofuck.hit_freeze(0.2)
