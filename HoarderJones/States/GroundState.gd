class_name GroundState
extends State

# Core child states
@onready var idle := $Idle as IdleState
@onready var run := $Run as RunState

func enter():
	super.enter()
	self.set_state(idle)

func do(delta: float) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		self.set_state(run)
	else:
		self.set_state(idle)

	self.current.do(delta)
