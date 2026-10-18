extends ColorRect
class_name LoadingScreen

signal got_black

func _enter_tree() -> void:
	if Autofuck.on_loading_screen == true:
		show()
		modulate = Color.WHITE
		await get_tree().create_timer(0.5).timeout
		var tween: = get_tree().create_tween().tween_property(self,"modulate",Color.TRANSPARENT, 0.2)
		await tween.finished
		Autofuck.on_loading_screen = false
		hide()
		return
	modulate = Color.TRANSPARENT
	hide()

func summon() -> void:
	show()
	var tween: = get_tree().create_tween().tween_property(self,"modulate",Color.WHITE, 0.2)
	await tween.finished
	await get_tree().create_timer(2.0).timeout
	got_black.emit()
	Autofuck.on_loading_screen = true
