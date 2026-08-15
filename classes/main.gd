class_name Main
extends Node

@export var anim : AnimationPlayer
var press_any : bool = false

func _ready() -> void:
	#anim.play("start splash")
	# plays the quick start animation (5s)
	# seria massa uma animação aq tmb mas vamo ver se ta so scope dps
	$PressAny.show()
	
	#await anim.animation_finished
	$Splash.queue_free()
	
	press_any = true

func _input(_event: InputEvent) -> void:
	if press_any and Input.is_anything_pressed():
		$PressAny.queue_free()
		$MainMenu.active = true
		$MainMenu.visible = true
		press_any = false
