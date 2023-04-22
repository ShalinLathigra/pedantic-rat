class_name AirState
extends State

# Sub States
@onready var jump := %StateMachine/Air/Jump as State
@onready var fall := %StateMachine/Air/Fall as State

func should_jump() -> bool:
	return Input.is_action_pressed("space") and self.core.is_on_floor()

func enter():
	super.enter()
	set_state(jump if should_jump() else fall)

func do(delta: float):
	if jump.is_finished or Input.is_action_just_released("space"):
		set_state(fall)
	# Handle X component of movement
	var dir = Input.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * self.core.stats.speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, self.core.stats.speed)

	current.do(delta)
	self.core.move_and_slide()


