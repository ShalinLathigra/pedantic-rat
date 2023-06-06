extends State

# Player Specific, to be moved later
@onready var ground := $Ground as GroundState
@onready var air := $Air as AirState
@onready var fringe := $Fringe as PrioritySelectorState

func startup() -> void:
	set_state(ground)

func do(delta: float) -> void:
	super.do(delta)
	# basic movement inputs
	if not core.is_state_locked:
		if fringe.should_process():
			set_state(fringe)
		elif air.should_jump or not core.is_on_floor():
			set_state(air)
		else:
			set_state(ground)
