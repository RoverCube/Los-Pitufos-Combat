class_name StateMachine
extends Node

@export var buffer_timer    : Timer
@export var all_states     : Array[State]
@export_range(0, 256) var starting_state : int
var current_state          : State
var buffered_state         : State

func _ready() -> void:
	buffer_timer.timeout.connect(_on_buffer_timer_timeout)

	for x in all_states:
		x.machine = self
		x.change_state.connect(change_state)
	current_state = all_states[starting_state]
	current_state._on_start_state()

func change_state(new_state_name: String) -> void:
	for x in all_states:
		if x.name.to_lower() == new_state_name.to_lower(): 
			current_state._on_end_state() # ends current
			x._on_start_state() # starts new
			print(current_state.name," to ",x.name)
			current_state = x # set as current

			# buffer
			if buffered_state == null: return
			if current_state.can_buffer_to.has(buffered_state):
				buffered_state._generic_buffer(current_state)
			else: return

func buffer_state(state: State, buffer_wait: float = 0.5):
	buffer_timer.start(buffer_wait)
	buffered_state = state

func _on_buffer_timer_timeout() -> void:
	buffered_state = null

func _physics_process(delta: float) -> void:
	if current_state.can_buffer_to.has(buffered_state):
		buffered_state._generic_buffer(current_state)
	current_state._check_change() # checks if it needs to change
	current_state._update_physics(delta) # updates
