class_name FiniteStateMachine
extends Node

signal changed_state(new: State,old: State)

var states   : Array[State]
var current  : State = null
var previous : State = null
@export var start_state_id: int = 0
@export var print_change  : bool = false

func _ready() -> void:
	for x in get_children(false):
		if x is State:
			states.insert(states.size(), x)
			x.fsm = self
			x.changed_state_to.connect(_on_state_change)

	current = states[start_state_id]
	current._start()

func _physics_process(delta: float) -> void:
	current._checks()
	current._physics_update(delta)

func _on_state_change(id: int) -> void:
	var state: State = states[id]
	previous = current
	current = state
	previous._end()
	current._start()
	if print_change: print(previous.name+" -> "+current.name)
	changed_state.emit(current,previous)

func find_state_by_name(what: String) -> State:
	for x in states:
		if x.name.to_lower() == what.to_lower():
			return x
	return null
