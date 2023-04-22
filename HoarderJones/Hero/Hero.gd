class_name Character
extends CharacterBody2D
# needs to have a custom stats object

# Core Character Components
@export var stats: Stats
@onready var animator := %Animator as AnimationPlayer
@onready var machine := %StateMachine as StateMachine

# Player Specific, to be moved later
@onready var ground: GroundState = %StateMachine/Ground as GroundState
@onready var air: AirState = %StateMachine/Air as AirState

func _physics_process(delta: float) -> void:
	print(air.should_jump())
#	# highest priority is air control
	if air.should_jump() or not is_on_floor():
		machine.set_state(air)
	else:
		machine.set_state(ground)

	machine.do(delta)
