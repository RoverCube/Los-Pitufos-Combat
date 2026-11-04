extends ColorRect
class_name LoadingScreen

signal got_black
func _enter_tree() -> void:
	if Autofuck.on_loading_screen == true:
		show()
		modulate = Color.WHITE
		$"Timer".start(0.5)
		await $"Timer".timeout
		var tween: = get_tree().create_tween().tween_property(self,"modulate",Color.TRANSPARENT, 0.2)
		await tween.finished
		Autofuck.on_loading_screen = false
		hide()
		return
	modulate = Color.TRANSPARENT
	hide()

func summon(wait:bool = true) -> void:
	show()
	var tween: = get_tree().create_tween().tween_property(self,"modulate",Color.WHITE, 0.2)
	await tween.finished
	if wait == true:
		$"Timer".start(2.0)
		await $"Timer".timeout
	got_black.emit()
	Autofuck.on_loading_screen = true
