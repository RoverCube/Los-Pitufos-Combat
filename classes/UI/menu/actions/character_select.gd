extends MenuAction

@export_enum("Campanha","Versus","Treino") var id: int
@export var cselect: Menu
@export var main: Menu
@export var anim: AnimationPlayer

func action() -> void:
	anim.play("go to cselect")
	await anim.animation_finished
	main.active = false
	cselect.active = true
	
