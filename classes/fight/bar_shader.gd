extends Sprite2D

@export_enum("Special1:0","Special2:1","Health1:2","Health2:3") var type: int
@onready var fight: Fight = $"../.."

func _process(_delta: float) -> void:
	var pussy: float
	if type == 0:
		pussy = float(fight.player_1.special_bar) / float(fight.player_1.special_bar_max)
	elif type == 1:
		pussy = float(fight.player_2.special_bar) / float(fight.player_2.special_bar_max)
	elif type == 2:
		pussy = float(fight.player_1.health) / float(fight.player_1.max_health)
	else:
		pussy = float(fight.player_2.health) / float(fight.player_2.max_health)
	material.set_shader_parameter("value",pussy)
