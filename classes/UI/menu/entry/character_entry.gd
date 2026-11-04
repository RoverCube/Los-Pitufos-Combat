class_name CharacterSEntry
extends MenuEntry

@export var c_name  : String
@export var texture : Texture
@export var big_one : Texture
@export var offset  : int = 0
@export var color_1 : Color
@export var color_2 : Color
@export var color_3 : Color
@export var color_4 : Color

var rects : Array[ColorRect]
const MAX_WIDTH: int   = 448

const MIN_WIDTH: int   = 128
const OMG_TRANS:       = Tween.TRANS_BACK
const TIME     : float = 0.2

func _ready() -> void:
	$Bg/Label.text = c_name
	$Bg/Label.label_settings.outline_color = color_3
	$Bg.texture.gradient.set_color(0, color_1)
	$Bg/CharacterTexture.material.set_shader_parameter("first_color", color_2)
	$Bg/CharacterTexture.material.set_shader_parameter("second_color", color_4)
	$Bg/CharacterTexture.material.set_shader_parameter("alt_base_color", color_3)
	$Bg/ColorRect.color = color_4
	$Bg/CharacterTexture.texture = texture

func confirm() -> void:
	pass

func _on_selected() -> void:
	await get_tree().create_timer(0.1).timeout
	var tween: Tween = get_tree().create_tween().set_trans(OMG_TRANS).set_parallel()
	tween.tween_property(self,"custom_minimum_size",
	Vector2(MAX_WIDTH,0), TIME)
	tween.tween_property($Bg.texture,"width", MAX_WIDTH, TIME)
	tween.tween_property($Bg/CharacterTexture,"position",Vector2(0,0),TIME)
	$Bg/CharacterTexture.material.set_shader_parameter("full_white", false)

func _on_deselected() -> void:
	await get_tree().create_timer(0.1).timeout
	var tween: Tween = get_tree().create_tween().set_trans(OMG_TRANS).set_parallel()
	tween.tween_property(self,"custom_minimum_size",
	Vector2(MIN_WIDTH,0), TIME)
	tween.tween_property($Bg.texture,"width", MIN_WIDTH, TIME)
	tween.tween_property($Bg/CharacterTexture,"position",Vector2(-192,0),TIME)
	$Bg/CharacterTexture.material.set_shader_parameter("full_white", true)
