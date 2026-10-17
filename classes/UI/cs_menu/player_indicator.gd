extends Sprite2D

@onready var cs_menu : CSMenu = get_parent()
@export var player_2 : bool
const time           : float = 0.05

func _ready() -> void:
	if player_2 == true:
		global_position = cs_menu.entries[cs_menu.p2_seletion].global_position + cs_menu.entries[cs_menu.p2_seletion].p2_indicator_pos
	else:
		global_position = cs_menu.entries[cs_menu.p1_seletion].global_position + cs_menu.entries[cs_menu.p1_seletion].p1_indicator_pos

func _input(_event: InputEvent) -> void:
	var pos: Vector2 
	if player_2 == true:
		pos = cs_menu.entries[cs_menu.p2_seletion].global_position + cs_menu.entries[cs_menu.p2_seletion].p2_indicator_pos
	else:
		pos = cs_menu.entries[cs_menu.p1_seletion].global_position + cs_menu.entries[cs_menu.p1_seletion].p1_indicator_pos
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self,"global_position", pos, time)
