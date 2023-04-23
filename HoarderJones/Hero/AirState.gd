class_name AirState
extends State

# Sub States
@onready var jump := %StateMachine/Air/Jump as State
@onready var fall := %StateMachine/Air/Fall as State

var should_jump: bool:
	get: return current != fall and jump.is_jump_buffered

func enter():
	super.enter()
	super.set_state(jump if should_jump else fall, true)

func do(delta: float):
	# Handle Coyote Time
	if current == fall and jump.do_late_jump:
		super.set_state(jump, true)

	# Handle X component of movement
	var dir = Input.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * self.core.stats.speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, self.core.stats.speed)

	current.do(delta)
	self.core.move_and_slide()

	# Transition to jump if needed
	if jump.is_finished:
		set_state(fall)

