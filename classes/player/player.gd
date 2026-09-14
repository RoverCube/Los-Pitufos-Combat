class_name Player
extends CharacterBody3D

@export var pn: int = 1 # PN = Player Number 1 or 2

@onready var sprite    : AnimatedSprite3D = $Sprite
@onready var col       : CollisionShape3D = $Collision
@onready var animation : AnimationPlayer  = $Animation

@export_range(100,225,25,"prefer_slider") var health: int  = 150
@export var speed     : float = 128.0
@export var air_speed : float = 64.0
@export var jump      : float = 12.0

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

func anim(animation_name: String) -> void:
	if self.animation == null or self.sprite == null: return
	if animation.has_animation(animation_name): animation.play(animation_name)
	else: push_warning(name," --- AnimationPlayer dosent have animation named ",animation_name)
	if sprite.sprite_frames.has_animation(animation_name): sprite.play(animation_name)
	else: push_warning(name," --- Sprite dosent have animation named ",animation_name)
