extends MenuAction

@export var menu     : Menu
@export var sub_menu : Menu

func action() -> void:
	menu.active = false
	sub_menu.active = true
	
	var tween := get_tree().create_tween().set_parallel().set_trans(Tween.TRANS_BACK)
	tween.tween_property(menu,"position",    Vector2(menu.position.x     - 256,menu.position.y), 0.25)
	tween.tween_property(sub_menu,"position",Vector2(sub_menu.position.x + 320,sub_menu.position.y), 0.25)
	tween.tween_property(sub_menu,"modulate",Color("ffff"), 0.25)
	
