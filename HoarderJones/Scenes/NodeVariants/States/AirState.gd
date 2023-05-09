class_name AirState
extends State

# Sub States
@onready var jump := $Jump as State
@onready var fall := $Fall as State

var gas: int:
	get: return core.stats.air_acc_rate
var speed: int:
	get: return core.stats.air_speed
var brakes: int:
	get: return core.stats.air_brake_speed

var should_jump: bool:
	get: return current != fall and jump.is_jump_buffered

var used_jump: bool

func enter():
	super.enter()
	super.set_state(jump if should_jump else fall)
	jump.finished.connect(func(): set_state(fall))
	used_jump = should_jump

func do(delta: float):
	# Handle Coyote Time
	if (current == fall) and jump.do_late_jump and not used_jump:
		super.set_state(jump)
		used_jump = true
	var dir = core.direction.x
	if dir:
		core.velocity.x = move_toward(core.velocity.x, dir * speed, brakes*delta)
	else:
		core.velocity.x = move_toward(core.velocity.x, 0, brakes*delta)

	current.do(delta)

func exit() -> void:
	current = null

