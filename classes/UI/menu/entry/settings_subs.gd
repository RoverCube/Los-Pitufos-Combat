class_name SettingSub
extends MenuEntry

@export var sub_menu: Menu

func _ready() -> void:
	$Label.text = name.to_lower()

func confirm() -> void:
	anim.play("enterSub")
	sub_menu.active = true
	sub_menu.show()
	menu.active = false
	menu.hide()
func _on_deselected() -> void:pass
func _on_selected() -> void:pass
