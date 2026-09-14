class_name VolumeSettingEntry
extends MenuEntry

@export var icon   : Texture
@export var offset : Vector2
@export_enum("music","sfx","voice") var type : int
@export var release_sfx : AudioStream
var value : float = 1:
	set(new):
		if type == 0: Autofuck.music_volume = new
		if type == 1: Autofuck.sfx_volume = new
		if type == 2: Autofuck.voice_volume = new
		value = new
var value_mod : float = 0.05


func _ready() -> void:
	$Handle.texture = icon
	if type == 0: value = Autofuck.music_volume
	if type == 1: value = Autofuck.sfx_volume
	if type == 2: value = Autofuck.voice_volume
	update_visual()

func _input(event: InputEvent) -> void:
	if !selected: return
	if event.is_action_pressed("UI Right",true):
		value = clampf(value + value_mod,0.0,1.0)
		update_visual()
	if event.is_action_pressed("UI Left",true):
		value = clampf(value - value_mod,0.0,1.0); 
		update_visual()
	if event.is_action_released("UI Left") or event.is_action_released("UI Right"):
		play_sfx(release_sfx)

func update_visual() -> void:
	$Handle.position = value * offset
	$Label.text = str(roundi(value*100))+"%"

func confirm() -> void: pass
func _on_selected() -> void: anim.play("selected")
func _on_deselected() -> void: anim.play("deselected")
