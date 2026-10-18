extends ColorRect
class_name LoadingScreen

signal got_black

@onready var loading_sprite: AnimatedSprite2D = $LoadingSprite
@export var enter: bool = false

func _enter_tree() -> void:
	if enter:
		show()
		modulate = Color.WHITE
		await get_tree().create_timer(0.5).timeout
		var tween: = get_tree().create_tween().tween_property(self,"modulate",Color.TRANSPARENT, 0.2)
		await tween.finished
		return
	modulate = Color.TRANSPARENT
	hide()

func summon() -> void:
	show()
	var tween: = get_tree().create_tween().tween_property(self,"modulate",Color.WHITE, 0.2)
	await tween.finished
	await get_tree().create_timer(2.0).timeout
	got_black.emit()
	var spritef: PackedStringArray = loading_sprite.sprite_frames.get_animation_names()
	loading_sprite.play(spritef[randi_range(0,spritef.size()-1)])
