class_name MenuEntry
extends Button

var menu : Menu

@export var anim: AnimationPlayer
@export var confirmed_action : MenuAction
var selected: bool = false:
	set(new):
		if selected == false and new == true:
			anim.play("selected")
		if selected == true and new == false:
			anim.play("deselected")
		selected = new

func _on_pressed() -> void:
	confirm()

func _input(_event: InputEvent) -> void:
	if not selected:
		return
	
	if Input.is_action_just_pressed("UI Accept"):
		confirm()


func confirm() -> void:
	if menu.active == true:
		#confirmed_action.entry = self
		confirmed_action.action()
