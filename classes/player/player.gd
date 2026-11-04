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
			$HitBox.scale.x =  1
		else:   
			sprite.offset.x = abs(sprite.offset.x) * -1
			$HitBox.scale.x = -1
		facing_negative = new

@onready var sprite    : AnimatedSprite3D = $Sprite
@onready var col       : CollisionShape3D = $HurtBox/HurtCol
@onready var animation : AnimationPlayer  = $Animation
@onready var hurt      : HurtBox = $HurtBox
@onready var machine   : StateMachine = $StateMachine

@export var frame_data : FrameDataManager

@export var collision_shape    : BoxShape3D
@export var collision_crouched : BoxShape3D

@export_range(100,225,25,"prefer_slider") var max_health: int  = 150
@export var speed     : float = 128.0
@export var air_speed : float = 64.0
@export var jump      : float = 12.0
@export var special_depeads : Array[int] = [4,2,4,2] # HP LP HK LK

var health: int  = 150:
	set(new):
		if new <= 0:
			health = 0
			fight.update_hud(player_id)
			died.emit(self)
			return
		health = new
		fight.update_hud(player_id)

var dir_input: float
var jump_input: bool
var crouch_input: bool

var attack_input: bool
var hp_input: bool
var lp_input: bool
var hk_input: bool
var lk_input: bool

var blocking   : bool = false
var block_input: bool

@export_range(3.0,6.0,1.0,"prefer_slider") var special_bar_max   : float = 2.0
@export_range(0.0,4.0,0.5,"prefer_slider") var special_bar_start : float = 2.0
var special_bar : float:
	set(new):
		special_bar = clampf(new, 0, special_bar_max)
		fight.update_hud(player_id, true)
var special_on  : bool # super
var s_input     : bool # super


func _ready() -> void:
	health = max_health
	col.shape = collision_shape
	col.position.y = collision_shape.size.y / 2
	special_bar = special_bar_start
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
	block_input = Input.is_action_pressed(str(player_id,"Block"))
	if Input.is_action_just_pressed(str(player_id,"#")) and special_on == false:
		special_on = true
		$Fire.show()
		await get_tree().create_timer(2.0).timeout
		special_on = false
		$Fire.hide()

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
	if animation.has_animation(animation_name): 
		animation.play("RESET")
		animation.queue(animation_name)
	else: push_warning(name," --- AnimationPlayer dosent have animation named ",animation_name)

func set_velocity_forwards(amount: float) -> void:
	if facing_negative == true:
		velocity.x = -amount
	else:
		velocity.x = amount

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
