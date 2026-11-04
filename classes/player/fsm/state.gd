@abstract
class_name State
extends Node

signal changed_state_to(new_id: int)
signal state_started()
signal state_ended()

var fsm : FiniteStateMachine

func _start() -> void:
	state_started.emit()
func _end() -> void:
	state_ended.emit()
func _checks() -> void: pass

#@warning_ignore("unused_parameter")
#func _update(delta: float) -> void: pass

@warning_ignore("unused_parameter")
func _physics_update(delta: float) -> void: pass

func change_state(id: int) -> void:
	changed_state_to.emit(id)

func generic(id) -> void:
	fsm.states[id]._generic_change(self)
	
@warning_ignore("unused_parameter")
func _generic_change(self_state: State) -> void: pass
