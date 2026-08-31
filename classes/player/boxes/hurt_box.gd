class_name HurtBox
extends Area3D

signal got_hurt(hit: HitBox)

@export var ignore : HitBox

func _on_area(area: Area3D) -> void:
	if area is HitBox and area != ignore:
		var hit_box := area as HitBox
		got_hurt.emit(hit_box)
		Autofuck.hit_freeze(float(hit_box.damage)/100)
