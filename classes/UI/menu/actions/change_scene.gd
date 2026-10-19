extends MenuAction

@export var loads : LoadingScreen
@export var scene: PackedScene

func action() -> void:
	loads.summon()
	await loads.got_black
	get_tree().change_scene_to_packed(scene)
