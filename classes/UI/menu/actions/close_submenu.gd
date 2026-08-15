extends MenuAction

@export var menu     : Menu
@export var sub_menu : Menu

func action() -> void:
	var tween := get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
	tween.tween_property(menu,"position",    Vector2(menu.position.x     + 256,menu.position.y), 0.25)
	tween.tween_property(sub_menu,"position",Vector2(sub_menu.position.x - 320,sub_menu.position.y), 0.25)
	tween.tween_property(sub_menu,"modulate",Color("fff0"), 0.25)
	
	await tween.finished

	menu.active = true
	sub_menu.change_current(-sub_menu.entries.size() +1)
	sub_menu.active = false
