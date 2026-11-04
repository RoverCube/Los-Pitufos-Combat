extends AudioStreamPlayer
class_name AudioPlayer

@export_enum("music","sfx","voice") var type : int

func play_this(audio: AudioStream,from_position: float= 0.0) -> void:
	stream = audio
	play(from_position)

func _ready() -> void:
	if type == 0: volume_linear *= Autofuck.music_volume
	if type == 1: volume_linear *= Autofuck.sfx_volume
	if type == 2: volume_linear *= Autofuck.voice_volume
