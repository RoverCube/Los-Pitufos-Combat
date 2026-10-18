extends MenuAction

@export var load : LoadingScreen
@export var scene: PackedScene

func action() -> void:
	load.summon()
	await load.got_black
	get_tree().change_scene_to_packed(scene)
