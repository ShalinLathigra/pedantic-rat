class_name FallState
extends State

var fall_curve: Curve:
	get: return self.core.stats.fall_curve
var max_fall_rate: int:
	get: return self.core.stats.max_fall_rate_pixels

@export var looping_fall_anim: String

var t: float
var previous_t: float
var skip_winddown: bool

func enter():
	t = 0
	previous_t = 0

	if skip_winddown:
		self.core.animator.play(looping_fall_anim)
	else:
		super.enter()
		self.core.animator.animation_set_next(anim, looping_fall_anim)

func do(delta: float):
	# need to evaluate the jump curve here
	t += delta
	self.is_finished = t >= 1

	var evaluated_t = 1.0 - fall_curve.sample(t)

	# Swap these around to handle the *-1 without adding lines
	self.core.velocity.y = evaluated_t * max_fall_rate
	previous_t = t
