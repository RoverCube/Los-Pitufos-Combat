class_name LPCCamera
extends Camera3D

@export var active: bool = true
@export var p1: Player
@export var p2: Player

func _process(_delta: float) -> void:
	if active == false: return
	position.x = (p1.position.x + p2.position.x)/2
	position.y = (p1.position.y + p2.position.y)/2 + 1.25
