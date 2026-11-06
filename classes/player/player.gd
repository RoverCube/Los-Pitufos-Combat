class_name Player
extends CharacterBody3D

signal died(player: Player)

@export_enum("Player 1:1","Player 2:2") var player_id: int = 1 # PN = Player Number 1 or 2

@onready var fight  : Fight  = get_parent()
var other_player    : Player
var facing_negative : bool = false:
	set(new):
		sprite.flip_h = !new
		if new: 
			sprite.offset.x = abs(sprite.offset.x)
			$HitBox.scale.x = +1
		else:   
			sprite.offset.x = abs(sprite.offset.x) * -1
			$HitBox.scale.x = -1
		facing_negative = new

@onready var sprite     : AnimatedSprite3D = $Sprite
@onready var col        : CollisionShape3D = $HurtBox/HurtCol
@onready var animation  : AnimationPlayer  = $Animation
@onready var hurt_box   : HurtBox = $HurtBox
@onready var hit_box    : HitBox = $HitBox
@onready var hit_col    : CollisionShape3D = $HitBox/HitCol
@onready var move_fsm   : FiniteStateMachine = $MovementFSM
@onready var atk_fsm    : FiniteStateMachine = $AttackFSM
@onready var anim_state : PSAnim = $MovementFSM/Anim
@onready var audio      : AudioPlayer = $AudioPlayer

@export var ult : FrameData
@export var slp : FrameData
@export var shp : FrameData
@export var slk : FrameData
@export var shk : FrameData
@export var lp  : FrameData
@export var hp  : FrameData
@export var lk  : FrameData
@export var hk  : FrameData
@export var aa  : FrameData
@export var ca  : FrameData

@export var col_stand  : BoxShape3D
@export var col_crouch : BoxShape3D
@export var col_jump   : BoxShape3D

@export_range(100,225,25,"prefer_slider") var max_health: int  = 150
@onready var health   : int = max_health:
	set(new):
		health = clamp(new, 0, max_health)
		fight.update_hud(player_id)
		if health == 0:
			died.emit(self)

@export var high_hit_duration : int = 4
@export var low_hit_duration  : int = 4

const WALK_SPEED : float = 128.0
const JUMP_FORCE : float =  10.0
const GRAVITY    : float =  28.0
const FALL       : float =  32.0
const AIR_SPEED  : float =  12.0

var dir_input    : float = 0.0
var jump_input   : bool  = false
var crouch_input : bool  = false
var attack_input : bool  = false
var hp_input     : bool  = false
var lp_input     : bool  = false
var hk_input     : bool  = false
var lk_input     : bool  = false
var block_input  : bool  = false

@export_range(3.0,6.0,1.0,"prefer_slider") var special_bar_max   : float = 2.0
@export_range(0.0,4.0,0.5,"prefer_slider") var special_bar_start : float = 2.0
@export var bar_gain_per_damage : float # (1 / max health) * 4

@export var enter_voicelines : Array[AudioStream]
var special_bar   : float:
	set(new):
		special_bar = clampf(new, 0, special_bar_max)
		fight.update_hud(player_id, true)
var special_onoff : bool :
	set(new):
		if new == true:
			$Fire.show()
			$Fire.play("Startup")
			await $Fire.animation_finished
			$Fire.play("Idle")
		if new == false:
			$Fire.play_backwards("Startup")
			await $Fire.animation_finished
			$Fire.hide()
		special_onoff = new
var s_input       : bool
var s_input_hold  : float = 0:
	set(new):
		if new >= 2.0:
			anim(ult.ult_anim)
			activate_fdata(ult)

func _ready() -> void:
	col.shape = col_stand
	col.position.y = col_stand.size.y / 2
	special_bar = special_bar_start
	bar_gain_per_damage = (1.0 - float(max_health)) * special_bar_max
	turn()

	await fight.ready
	await fight.animation.animation_finished
	await fight.walkie.finished
	await fight.animation.animation_finished
	await fight.animation.animation_finished

	move_fsm.process_mode = Node.PROCESS_MODE_INHERIT
	atk_fsm.process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta: float) -> void:
	dir_input    = Input.get_axis(str(player_id,"Left"),str(player_id,"Right"))
	jump_input   = Input.is_action_just_pressed(str(player_id,"Jump"))
	crouch_input = Input.is_action_pressed(str(player_id,"Crouch"))
	hp_input     = Input.is_action_just_pressed(str(player_id,"HP"))
	lp_input     = Input.is_action_just_pressed(str(player_id,"LP"))
	hk_input     = Input.is_action_just_pressed(str(player_id,"HK"))
	lk_input     = Input.is_action_just_pressed(str(player_id,"LK"))
	attack_input = hp_input or lp_input or hk_input or lk_input
	block_input  = Input.is_action_pressed(str(player_id,"Block"))
	if Input.is_action_just_pressed(str(player_id,"#")):
		s_input = true
		if atk_fsm.process_mode == Node.PROCESS_MODE_INHERIT:
			special_onoff = true
	else: s_input = false
	if Input.is_action_just_released(str(player_id,"#")):
		await get_tree().create_timer(2.0).timeout
		special_onoff = false
	if Input.is_action_just_pressed(str(player_id,"#")):
		s_input_hold += delta
	else:
		s_input_hold = 0.0

	if $Fire.visible:
		$Fire.global_position = fight.camera.unproject_position(Vector3(position.x,col.shape.size.y/2 +0.5+ position.y,0))

	if audio.playing == true:
		pass

func _physics_process(_delta: float) -> void: move_and_slide()		

func turn() -> void:
	if position.x - other_player.position.x < 0:
		facing_negative = true
	else:
		facing_negative = false

func anim(animation_name: String) -> void:
	if sprite == null: return
	if sprite.sprite_frames.has_animation(animation_name): sprite.play(animation_name)
	else: push_warning("Sprite dosent have animation named "+animation_name)

func activate_fdata(fdata: FrameData) -> void:
	var anima: String = sprite.animation
	hit_col.shape = fdata.col
	hit_col.position = fdata.col_position
	hit_col.rotation_degrees = fdata.col_rotation
	hit_box.damage       = fdata.damage
	hit_box.block_damage = fdata.block_damage
	hit_box.stun_time    = fdata.stun_time
	hit_box.knockback    = fdata.knockback
	hit_box.low_hit      = fdata.low_hit
	hit_box.sfx_type     = fdata.sfx_type
	special_bar -= fdata.bar_use
	
	if fdata.bar_use != 0.0:
		special_onoff = false

	if fdata.ultimate_data != null:
		fdata.ultimate_data.activate(self)

	while sprite.animation == anima:
		await sprite.frame_changed

		if (fdata.impulses.size()) >= sprite.frame-1 and fdata.impulses.size() != 0:
			velocity.x = fdata.impulses[sprite.frame-1] * (float(facing_negative) * 2 - 1)

		if sprite.frame-1 == fdata.active_start:
			hit_col.disabled = false
		if sprite.frame-1 == fdata.active_end:
			hit_col.disabled = true
