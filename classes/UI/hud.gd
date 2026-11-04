class_name HUD
extends Control

# Player
@onready var p1_health_bar : Sprite2D = $Time/P1HealthBar
@onready var p2_health_bar : Sprite2D = $Time/P2HealthBar
@onready var p1_super_bar  : Sprite2D = $Super/P1SuperBar
@onready var p2_super_bar  : Sprite2D = $Super/P2SuperBar
# Fight
@onready var time_left  : Label = $Time/TimeLeft
@onready var p1_score_1 : Sprite2D = $Time/P1Score1
@onready var p1_score_2 : Sprite2D = $Time/P1Score2
@onready var p2_score_1 : Sprite2D = $Time/P2Score1
@onready var p2_score_2 : Sprite2D = $Time/P2Score2
const SCORE_1 = preload("uid://d37hnjw4h00rv")
const SCORE_2 = preload("uid://c11xk6eeo2434")
const SCORE_1_GREY = preload("uid://cv0hr627vdi46")
const SCORE_2_GREY = preload("uid://bxw37piiveeg3")

# max health = 200
func set_player1_health(value: int) -> void: p1_health_bar.material.set_shader_parameter("progress", float(value / 200.0))
func set_player2_health(value: int) -> void: p2_health_bar.material.set_shader_parameter("progress", float(value / 200.0))

func set_player1_super(value: int) -> void: p1_super_bar.material.set_shader_parameter("progress", float(value / 3.0))
func set_player2_super(value: int) -> void: p2_super_bar.material.set_shader_parameter("progress", float(value / 3.0))
