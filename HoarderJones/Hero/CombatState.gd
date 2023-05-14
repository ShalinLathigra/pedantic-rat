class_name PlayerLightComboState
extends State

# Should be self-detecting the entry condition
var brakes: int:
	get: return core.stats.brake_speed

@onready var sub_states: Array[State] = [
	$"Strike 1" as State,
	$"Strike 2" as State,
	$"Strike 3" as State
]

var within_combo_window: bool:
	get: return tick_of_last_attack_input + combo_input_window > Time.get_ticks_msec()

var index: int
var tick_of_last_attack_input: int
var combo_input_window: int = 500
var in_progress: bool

func should_process() -> bool:
	return in_progress or (not core.is_state_locked and is_ready_to_reenter and within_combo_window)

# when you enter the combo, lock this up.
func enter() -> void:
	super.enter()
	core.lock_components(true)
	index = 0
	tick_of_last_attack_input = 0
	set_state(sub_states[index])
	in_progress = true

func do(delta: float) -> void:
	core.velocity.x = move_toward(core.velocity.x, 0, brakes*delta)
	# if can early exit and within
	if not core.animator.is_playing():
		in_progress = false
		tick_of_last_attack_input = 0
		core.release()

	if not core.can_early_exit:
		return
	if index < len(sub_states) - 1 and within_combo_window:
		index += 1
		tick_of_last_attack_input = 0
		set_state(sub_states[index])

# Handle entering this state
func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("light_attack"):
		return
	tick_of_last_attack_input = Time.get_ticks_msec()
