class_name AirState
extends State

func should_jump() -> bool:
	return Input.is_action_pressed("space") and self.core.is_on_floor()

func enter():
	core.animator.play(anim)
	if should_jump():
		self.core.velocity.y = self.core.stats.jump_force * -1

func do(delta: float):
	var dir = Input.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * self.core.stats.speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, self.core.stats.speed)
	# No matter what, velocity.y must decrement
	self.core.velocity.y += 98 * delta
	self.core.move_and_slide()

