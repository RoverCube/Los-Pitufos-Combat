extends Node2D

const SOUND = preload("uid://cxn7fp4iq3eaw")

var ready_1: bool = false:
	set(new):
		if new == true:
			ready_1 = new
			var a: AudioPlayer = AudioPlayer.new()
			add_child(a)
			a.type = 1
			a.play_this(SOUND)
			get_tree().create_tween().tween_property($Label/Confirm1,"modulate",Color.WHITE,0.2)
			await a.finished
			a.queue_free()
var ready_2: bool = false:
	set(new):
		if new == true:
			ready_2 = new
			var a: AudioPlayer = AudioPlayer.new()
			add_child(a)
			a.type = 1
			a.play_this(SOUND)
			get_tree().create_tween().tween_property($Label/Confirm2,"modulate",Color.WHITE,0.2)
			await a.finished
			a.queue_free()

func _input(_event: InputEvent) -> void:
	ready_1 = Input.is_action_just_pressed("1Left") or Input.is_action_just_pressed("1Right") or Input.is_action_just_pressed("1Jump") or Input.is_action_just_pressed("1Crouch") or Input.is_action_just_pressed("1Block") or Input.is_action_just_pressed("1LP") or Input.is_action_just_pressed("1HP") or Input.is_action_just_pressed("1LK") or Input.is_action_just_pressed("1HK") or Input.is_action_just_pressed("1#")
	ready_2 = Input.is_action_just_pressed("2Left") or Input.is_action_just_pressed("2Right") or Input.is_action_just_pressed("2Jump") or Input.is_action_just_pressed("2Crouch") or Input.is_action_just_pressed("2Block") or Input.is_action_just_pressed("2LP") or Input.is_action_just_pressed("2HP") or Input.is_action_just_pressed("2LK") or Input.is_action_just_pressed("2HK") or Input.is_action_just_pressed("2#")
	if ready_1 and ready_2:
		
		get_tree().create_tween().tween_property($Label/Black,"modulate",Color.WHITE,0.5)
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://scenes/fight/fight.tscn")


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/controller_mapper.tscn")
