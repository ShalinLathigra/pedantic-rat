class_name FringeState
extends State

# Sub States
@onready var ledge_grab := $LedgeGrab as State

func enter() -> void:
	super.enter()
	self.core.is_transition_blocked = true
	self.set_state(ledge_grab)

func exit() -> void:
	super.enter()
	self.core.is_transition_blocked = false
