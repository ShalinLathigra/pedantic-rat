class_name AirState
extends State

# Sub States
@onready var jump := $Jump as State
@onready var fall := $Fall as State

var speed: int:
	get: return self.core.stats.air_speed

var should_jump: bool:
	get: return current != fall and jump.is_jump_buffered

func enter():
	super.enter()
	super.set_state(jump if should_jump else fall, true)
	jump.finished.connect(func(): set_state(fall))

func do(delta: float):
	# Handle Coyote Time
	if (current == fall) and jump.do_late_jump:
		super.set_state(jump, true)
	var dir = InputManager.get_axis("left", "right")
	if dir:
		self.core.velocity.x = dir * speed
	else:
		self.core.velocity.x = move_toward(self.core.velocity.x, 0, speed)

	current.do(delta)
	self.core.move_and_slide()

