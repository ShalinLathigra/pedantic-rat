class_name RunState
extends State

func do(_delta: float) -> void:
	var dir = Input.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * self.core.stats.speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, self.core.stats.speed)

	self.core.move_and_slide()
