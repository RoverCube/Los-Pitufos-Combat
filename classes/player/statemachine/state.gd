@abstract
class_name State
extends Node

@warning_ignore("unused_signal")
signal change_state(new_state_name: String)

@export var can_buffer_to : Array[State]

var machine                : StateMachine

func _on_start_state() -> void: pass
func _on_end_state() -> void: pass
@warning_ignore("unused_parameter")
func _update_physics(delta: float) -> void: pass
func _check_change() -> void: pass
@warning_ignore("unused_parameter")
func _generic_change(self_state: State) -> void: pass
@warning_ignore("unused_parameter")
func _generic_buffer(self_state: State) -> void: pass


func generic_to(id: int):
	machine.all_states[id]._generic_change(self)
