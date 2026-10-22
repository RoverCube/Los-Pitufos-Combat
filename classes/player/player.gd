class_name Player
extends CharacterBody3D

@export_enum("Player 1:1","Player 2:2") var player_id: int = 1 # PN = Player Number 1 or 2

@onready var fight  : Fight  = get_parent()
var other_player    : Player
var facing_negative : bool = false:
	set(new):
		sprite.flip_h = !new
		facing_negative = new

@onready var sprite    : AnimatedSprite3D = $Sprite
@onready var col       : CollisionShape3D = $Collision
@onready var animation : AnimationPlayer  = $Animation

@export var collision_shape    : BoxShape3D
@export var collision_crouched : BoxShape3D

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

func _ready() -> void:
	col.shape = collision_shape
	col.position.y = collision_shape.size.y / 2
	turn()

func _input(_event: InputEvent) -> void:
	dir_input = Input.get_axis(str(player_id,"Left"),str(player_id,"Right"))
	jump_input = Input.is_action_just_pressed(str(player_id,"Jump"))
	crouch_input = Input.is_action_pressed(str(player_id,"Crouch"))
	hp_input = Input.is_action_just_pressed(str(player_id,"HP"))
	lp_input = Input.is_action_just_pressed(str(player_id,"LP"))
	hk_input = Input.is_action_just_pressed(str(player_id,"HK"))
	lk_input = Input.is_action_just_pressed(str(player_id,"LK"))
	attack_input = hp_input or lp_input or hk_input or lk_input
	s_input = Input.is_action_just_pressed(str(player_id,"#"))

func turn() -> void:
	if position.x - other_player.position.x < 0:
		facing_negative = true
	else:
		facing_negative = false

func anim(animation_name: String, use_animation: bool = false, only_animation: bool = false) -> void:
	if self.animation == null or self.sprite == null: return

	if only_animation == false:
		if sprite.sprite_frames.has_animation(animation_name): sprite.play(animation_name)
		else: push_warning(name," --- Sprite dosent have animation named ",animation_name)

	if use_animation == false: return
	if animation.has_animation(animation_name): animation.play(animation_name)
	else: push_warning(name," --- AnimationPlayer dosent have animation named ",animation_name)
