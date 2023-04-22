class_name JumpState
extends State

# Properties
var jump_curve: Curve:
	get: return self.core.stats.jump_curve
var jump_pixels: int:
	get: return self.core.stats.jump_max_height_pixels
var max_jump_ticks: int:
	get: return self.core.stats.jump_max_ticks

var start_tick: int
var previous_t: float
var start_height:int

func enter() -> void:
	super.enter()
	start_tick = Time.get_ticks_msec()
	previous_t = 0
	start_height = self.core.position.y

func do(delta: float) -> void:
	# need to evaluate the jump curve here
	var t = float(Time.get_ticks_msec() - start_tick) / max_jump_ticks
	if t == 0:
		return
	var current_height = jump_curve.sample(t) * jump_pixels
	var last_height = jump_curve.sample(previous_t) * jump_pixels

	# Swap these around to handle the *-1 without adding lines
	self.core.velocity.y = (last_height - current_height) / (delta)
	previous_t = t

	self.is_finished = t >= 1
