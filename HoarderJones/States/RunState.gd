class_name RunState
extends State

var speed: int:
	get: return self.core.stats.speed

func do(_delta: float) -> void:
	var dir = Input.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, speed)

	self.core.move_and_slide()
