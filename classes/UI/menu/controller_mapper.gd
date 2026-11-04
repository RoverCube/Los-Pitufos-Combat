extends Button

const actions: Array[String] = ["Left","Right","Jump","Crouch","HP","LP","HK","LK","#","DLeft","DRight","DUp","DDown"]
@export_enum("Left","Right","Jump","Crouch","HP","LP","HK","LK","#","DLeft","DRight","DUp","DDown","Exit:-1") var id: int
@export_enum("Player1:1","Player2:2") var player: int = 1
var binding: bool = false
@export var loads: LoadingScreen

func _enter_tree() -> void:
	connect("pressed",on_pressed)
	text = actions[id]

func on_pressed() -> void:
	if id == -1:
		loads.summon()
		await loads.got_black
		get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
	text = "binding "+actions[id]
	binding = true

func _input(event: InputEvent) -> void:
	if event is InputEventMouse: return
	if event is InputEventJoypadMotion:
		if abs(event.axis_value) <= 0.5: return
	if event.is_released(): return
	if binding == false: return
	
	map_input(event, false)


func map_input(input: InputEvent,p2: bool = false) -> void:
	var num: String
	if p2: num = "2"
	else: num = "1"
	text = actions[id]+" = "+input.as_text()
	InputMap.action_erase_events(str(num,actions[id]))
	InputMap.action_add_event(str(num,actions[id]),input)
	binding = false
