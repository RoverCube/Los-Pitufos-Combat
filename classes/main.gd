class_name Main
extends Node

@onready var anim  : AnimationPlayer = $Animation
var press_any      : bool = false
var input_sequence : String

func _ready() -> void:
	#anim.play("start splash")
	# plays the quick start animation (5s)
	# seria massa uma animação aq tmb mas vamo ver se ta so scope dps
	$PressAny.show()
	
	#await anim.animation_finished
	$Splash.queue_free()
	$BgMusic.play()
	press_any = true

func _input(_event: InputEvent) -> void:
	if press_any and Input.is_anything_pressed():
		$PressAny.queue_free()
		$MainMenu.active = true
		$MainMenu.visible = true
		press_any = false
	
	if Input.is_action_just_pressed("UI Up"): input_sequence += "w"
	if Input.is_action_just_pressed("UI Down"): input_sequence += "s"
	if Input.is_action_just_pressed("UI Right"): input_sequence += "d"
	if Input.is_action_just_pressed("UI Left"): input_sequence += "a"
	
	if "wwssdadawsws" in input_sequence and Autofuck.gay_mode == false:
		print("sex")
		Autofuck.turn_gay()
