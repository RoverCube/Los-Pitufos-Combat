class_name SettingSub
extends MenuEntry

@export var sub_menu: Menu

func confirm() -> void:
	anim.play("enterSub")
	sub_menu.active = true
	sub_menu.show()
	menu.active = false
	menu.hide()
func _on_deselected() -> void:pass
func _on_selected() -> void:pass
