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

@onready var sprite    : AnimatedSprite3D = $Sprite
@onready var col       : CollisionShape3D = $HurtBox/HurtCol
@onready var animation : AnimationPlayer  = $Animation
@onready var hurt      : HurtBox = $HurtBox

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

const WALK_SPEED: float = 128.0
const JUMP_FORCE: float =  12.0
const GRAVITY   : float =  32.0
const FALL      : float =  32.0
const AIR_SPEED : float =  12.0

var dir_input    : float = 0.0
var jump_input   : bool  = false
var crouch_input : bool  = false
var attack_input : bool  = false
var hp_input     : bool  = false
var lp_input     : bool  = false
var hk_input     : bool  = false
var lk_input     : bool  = false
var blocking     : bool  = false
var block_input  : bool  = false


@export_range(3.0,6.0,1.0,"prefer_slider") var special_bar_max   : float = 2.0
@export_range(0.0,4.0,0.5,"prefer_slider") var special_bar_start : float = 2.0
var special_bar   : float:
	set(new):
		special_bar = clampf(new, 0, special_bar_max)
		fight.update_hud(player_id, true)
var special_onoff : bool 
var s_input       : bool:
	set(new):
		if special_onoff == false:
			special_onoff = true
			#$Fire.show() 
			await get_tree().create_timer(2.0).timeout
			special_onoff = false
			#$Fire.hide()	
		s_input = new

func _ready() -> void:
	col.shape = col_stand
	col.position.y = col_stand.size.y / 2
	special_bar = special_bar_start
	turn()

func _input(_event: InputEvent) -> void:
	dir_input    = Input.get_axis(str(player_id,"Left"),str(player_id,"Right"))
	jump_input   = Input.is_action_just_pressed(str(player_id,"Jump"))
	crouch_input = Input.is_action_pressed(str(player_id,"Crouch"))
	hp_input     = Input.is_action_just_pressed(str(player_id,"HP"))
	lp_input     = Input.is_action_just_pressed(str(player_id,"LP"))
	hk_input     = Input.is_action_just_pressed(str(player_id,"HK"))
	lk_input     = Input.is_action_just_pressed(str(player_id,"LK"))
	attack_input = hp_input or lp_input or hk_input or lk_input
	block_input  = Input.is_action_pressed(str(player_id,"Block"))
	s_input      = Input.is_action_just_pressed(str(player_id,"#"))

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

func spawn_porjactile(look: Texture, local_pos: Vector3, damage: int, life: float, angle: Vector2 = Vector2.LEFT, p_speed: float = 1) -> void:
	var body: CharacterBody3D = CharacterBody3D.new()
	body.velocity = Vector3(angle.x,angle.y,0).normalized() * p_speed
	body.top_level = true
	body.global_position = to_global(local_pos)
	const HIT_SCENE = preload("res://scenes/player/hit_box.tscn")
	var hit: HitBox = HIT_SCENE.instantiate()
	body.add_child(hit)
	hit.damage = damage
	var sprir: Sprite3D = Sprite3D.new()
	body.add_child(sprir)
	sprir.texture = look
	sprir.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	
	add_child(body)
	await get_tree().create_timer(life).timeout
	body.queue_free()
