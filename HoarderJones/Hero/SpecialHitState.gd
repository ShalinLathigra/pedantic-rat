extends State

var state_set: Array[State]
var state: State
var current_index: int

# if the state finishes, move on to the next one.
# if the state cancels, release everything

func _ready() -> void:
	state_set = get_child_states()
	current_index = 0
	state = state_set[current_index]

func should_process() -> bool:
	if not is_ready_to_reenter:
		return false
	return state.should_process()

func enter() -> void:
	super.enter()
	current_index = 0
	lock()
	state = state_set[current_index]
	set_state(state, true)
