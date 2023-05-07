class_name RunState
extends State

var speed: int:
	get: return core.stats.run_speed
var gas: int:
	get: return core.stats.acc_rate
var brakes: int:
	get: return core.stats.brake_speed

func do(delta: float) -> void:
	var dir = InputManager.get_axis("left", "right")
	if dir:
		core.velocity.x = move_toward(core.velocity.x, dir * speed, gas * delta)
	else:
		core.velocity.x = move_toward(core.velocity.x, 0, brakes*delta)
