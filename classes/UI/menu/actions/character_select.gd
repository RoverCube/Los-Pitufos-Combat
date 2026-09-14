extends MenuAction

@export_enum("Campanha","Versus","Treino") var id: int

func action() -> void:
	print(id)#get_tree().change_scene_to_file("res://scenes/menus/character_select.tscn")
