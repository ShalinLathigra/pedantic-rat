class_name GroundState
extends State

# Core child states
@onready var idle := $Idle as State
@onready var run := $Run as RunState

func enter():
	super.enter()
	self.set_state(idle)

func do(delta: float) -> void:
	if abs(core.direction.x) > core.stats.threshold or core.velocity.x != 0:
		self.set_state(run)
	else:
		self.set_state(idle)

	self.current.do(delta)
