class_name HitBox
extends Area3D

@export var damage: int = 25
@export var knockback: int = 0


func _on_area_entered(area: Area3D) -> void:
	if area is HitBox:
		Autofuck.hit_freeze(0.5)
