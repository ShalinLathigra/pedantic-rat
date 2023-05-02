class_name RunState
extends State

var speed: int:
	get: return self.core.stats.run_speed
var brakes: int:
	get: return self.core.stats.brake_speed

func do(delta: float) -> void:
	var dir = InputManager.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, brakes*delta)

func exit() -> void:
	self.core.velocity.x = 0
