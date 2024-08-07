class_name PlayerLightComboState
extends State

# Should be self-detecting the entry condition
var brakes: int:
	get: return core.stats.brake_speed
var combo_input_window: int:
	get: return core.stats.combo_input_window
var input_buffer: int:
	get: return core.stats.input_buffer_ticks

var sub_states: Array[State]

var within_combo_window: bool:
	get: return tick_of_last_attack_input + combo_input_window > Time.get_ticks_msec()
var entry_input_buffered: bool:
	get: return tick_of_last_attack_input + input_buffer > Time.get_ticks_msec()

var index: int
var tick_of_last_attack_input: int
var in_progress: bool
var entry_direction: Vector2

func _ready():
	super._ready()
	sub_states = get_child_states()

func should_process() -> bool:
	return in_progress or (not core.is_state_locked and is_ready_to_reenter and (index > 0 and within_combo_window or entry_input_buffered))

# when you enter the combo, lock this up.
func enter() -> void:
	super.enter()
	core.lock_direction()
	index = 0
	tick_of_last_attack_input = 0
	set_state(sub_states[index])
	in_progress = true
	entry_direction = core.facing

func exit() -> void:
	super.exit()
	index = 0

func do(delta: float) -> void:
	core.velocity.x = move_toward(core.velocity.x, 0, brakes*delta)
	# if can early exit and within
	if not core.animator.is_playing():
		in_progress = false
		tick_of_last_attack_input = 0
		core.release_direction()

	if not core.can_early_exit:
		return
	core.is_direction_locked = false
	if index < len(sub_states) - 1 and within_combo_window:
		index += 1
		tick_of_last_attack_input = 0
		core.is_direction_locked = false
		# determine if player should turn around
		set_state(sub_states[index])

# Handle entering this state
func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("light_attack"):
		return
	tick_of_last_attack_input = Time.get_ticks_msec()
