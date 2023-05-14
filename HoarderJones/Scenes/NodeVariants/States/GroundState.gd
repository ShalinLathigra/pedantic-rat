class_name GroundState
extends State

# Core child states
@onready var idle := $Idle as State
@onready var run := $Run as RunState
@onready var light_combo := $LightCombo  as PlayerLightComboState

func enter():
	super.enter()
	self.set_state(idle)

func do(delta: float) -> void:
	if light_combo.should_process():
		self.set_state(light_combo)
	elif run.should_process():
		self.set_state(run)
	else:
		self.set_state(idle)

	self.current.do(delta)
