class_name Character
extends CharacterBody2D
# needs to have a custom stats object

# Core Character Components
@export var stats: Stats
@onready var animator := %Animator as AnimationPlayer
@onready var sprite := %Sprite as Sprite2D
@onready var machine := %StateMachine as StateMachine

# Player Specific, to be moved later
@onready var ground: GroundState = %StateMachine/Ground as GroundState
@onready var air: AirState = %StateMachine/Air as AirState

func _physics_process(delta: float) -> void:
#	# highest priority is air control
	if air.should_jump() or not is_on_floor():
		machine.set_state(air)
	else:
		machine.set_state(ground)

	machine.do(delta)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left"):
		sprite.flip_h = true
		sprite.position.x = sprite.offset.x * -2
	if event.is_action_pressed("right"):
		sprite.flip_h = false
		sprite.position.x = 0
