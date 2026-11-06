class_name HitBox
extends Area3D

@export_range(-1,500) var damage       : int = 25
@export_range(-1,500) var block_damage : int = -1
@export_range(0.25,3) var stun_time    : float = 0.25
@export_range(0,10)   var knockback    : float = 0.0
@export               var low_hit      : bool = false
@export_enum("Punch:0","Slash:1")
var sfx_type     : int = 0
const SFX : Array[Array] = [SFX_HIT,[SWORD_SWING]]
const SFX_HIT: Array[AudioStream] = [HIT,HIT_2,HIT_3]
const HIT = preload("uid://bksfkgj0nu4gn")
const HIT_3 = preload("uid://cn2ie38hilqlt")
const HIT_2 = preload("uid://bswp7h6dfivh")
const SWORD_SWING = preload("uid://cbtk3400onlke")

func _on_area_entered(area: Area3D) -> void:
	if area is HitBox:
		Autofuck.hit_freeze(0.2)
