class_name JumpState
extends State

# Properties
# Stats links
var jump_curve: Curve:
	get: return core.stats.jump_curve
var jump_pixels: int:
	get: return core.stats.jump_max_height_pixels
var max_jump_ticks: int:
	get: return core.stats.jump_max_ticks
var min_jump_ticks: int:
	get: return core.stats.jump_min_ticks
var input_buffer_ticks: int:
	get: return core.stats.input_buffer_ticks

# Jump buffering
var elapsed_ticks: int:
	get: return Time.get_ticks_msec() - start_tick
var is_jump_cancelled: bool:
	get: return (not jump_held) and elapsed_ticks > min_jump_ticks

var tick_of_last_jump_input: int
var start_tick: int
var previous_t: float
var start_height:float
var jump_held: bool

func should_process() -> bool:
	return Time.get_ticks_msec() <= tick_of_last_jump_input + input_buffer_ticks

func enter() -> void:
	super.enter()
	start_tick = Time.get_ticks_msec()
	previous_t = 0
	start_height = core.position.y
	jump_held = InputManager.is_action_pressed("jump")

func do(delta: float) -> void:
	# need to evaluate the jump curve here
	var t = float(elapsed_ticks) / max_jump_ticks
	if t == 0:
		return
	var current_height = jump_curve.sample(t) * jump_pixels
	var last_height = jump_curve.sample(previous_t) * jump_pixels

	# Swap these around to handle the *-1 without adding lines
	core.velocity.y = (last_height - current_height) / (delta)
	previous_t = t
	# Detect early cancel
	if t >= 1 or is_jump_cancelled:
		self.on_finished.emit()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		tick_of_last_jump_input = Time.get_ticks_msec()
	if event.is_action_released("jump"):
		jump_held = false
