class_name PriorityState
extends State

@export var state_set: Array[State]

var state: State

func should_process() -> bool:
	for s in state_set:
		if s.should_process():
			state = s
			return true
	return false

func enter() -> void:
	super.enter()
	set_state(state, true)
