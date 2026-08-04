class_name Player
extends CharacterBody2D

var pn: int = 1 # PN = Player Number 1 or 2

@export_range(100,225,25,"prefer_slider") var health: int  = 150
@export var speed: float = 10.0
@export var jump:  float = 10.0

var dir_input: float
var jump_input: bool
var crouch_input: bool

var attack_input: bool
var hp_input: bool
var lp_input: bool
var hk_input: bool
var lk_input: bool

var s_input: bool # super
var special: bool # super

func _input(_event: InputEvent) -> void:
	dir_input = Input.get_axis(str(pn,"Left"),str(pn,"Right"))
	jump_input = Input.is_action_pressed(str(pn,"Jump"))
	crouch_input = Input.is_action_pressed(str(pn,"Crouch"))
	hp_input = Input.is_action_pressed(str(pn,"HP"))
	lp_input = Input.is_action_pressed(str(pn,"LP"))
	hk_input = Input.is_action_pressed(str(pn,"HK"))
	lk_input = Input.is_action_pressed(str(pn,"LK"))
	attack_input = hp_input or lp_input or hk_input or lk_input
	s_input = Input.is_action_pressed(str(pn,"#"))
