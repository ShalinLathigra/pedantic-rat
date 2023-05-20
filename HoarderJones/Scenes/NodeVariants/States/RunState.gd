class_name RunState
extends State

var speed: int:
	get: return core.stats.run_speed
var gas: int:
	get: return core.stats.acc_rate
var brakes: int:
	get: return core.stats.brake_speed

func should_process() -> bool:
	return abs(core.direction.x) > core.stats.threshold or core.velocity.x != 0

func do(delta: float) -> void:
	var dir = core.direction.x
	if dir != 0:
		core.velocity.x = move_toward(core.velocity.x, dir * speed, gas * delta)
	else:
		core.velocity.x = move_toward(core.velocity.x, 0, brakes*delta)
