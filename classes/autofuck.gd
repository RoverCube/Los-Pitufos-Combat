extends Node

const HEHE = preload("uid://bfb2dqgmai451")

var gay_mode     : bool
# PREFERENCES
var music_volume : float = 0.0
var sfx_volume   : float = 1.0
var voice_volume : float = 1.0
# INPUT SETTINGS

func load_save_file() -> void: pass
func save_save_file() -> void: pass



func turn_gay() -> void:
	gay_mode = true
	var audio := AudioPlayer.new()
	audio.stream = HEHE
	audio.type = 2
	audio.autoplay = true
	add_child(audio)
	await audio.finished
	audio.queue_free()
	print("gay")

func hit_freeze(seconds: float) -> void:
	Engine.time_scale = 0.0
	await get_tree().create_timer(seconds, true, false, true).timeout
	Engine.time_scale = 1.0
