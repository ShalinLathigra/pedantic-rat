class_name PrioritySelectorState
extends State

var state_set: Array[State]

@export var state: State

func _ready() -> void:
	state_set = get_child_states()

func should_process() -> bool:
	for s in state_set:
		if s.should_process():
			state = s
			return true
	return false

func enter() -> void:
	super.enter()
	set_state(state, true)
