class_name FrameData
extends Resource

@export               var active_start : int = 1
@export               var active_end   : int = 2
@export_range(-1,500) var damage       : int = 25
@export_range(-1,500) var block_damage : int = -1
@export_range(0.15,3) var stun_time    : float = 0.25
@export_range(0,10)   var knockback    : float = 0.0
@export               var low_hit      : bool = false
@export               var sfx_type     : int = 0
@export               var bar_use      : float = 0
@export               var impulses     : Array[float]
@export_category("Collision")
@export var col          : BoxShape3D
@export var col_position : Vector3
@export var col_rotation : Vector3
