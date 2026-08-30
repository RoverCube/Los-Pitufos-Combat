extends Node


var gay_mode     : bool
# PREFERENCES
var music_volume : float = 1.0
var sfx_volume   : float = 1.0
var voice_volume : float = 1.0

func turn_gay() -> void:
	gay_mode = true
	var audio := AudioPlayer.new()
	audio.stream # hehe michal jackson
	audio.type = 2
	audio.autoplay = true
	add_child(audio)
	await audio.finished
	audio.queue_free()
	print("gay")
