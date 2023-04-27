class_name Character
extends CharacterBody2D
# needs to have a custom stats object

# Core Character Components
@export var stats: Stats
@onready var shape := %CollisionShape2D.shape as RectangleShape2D
@onready var animator := %Animator as AnimationPlayer
@onready var sprite := %Sprite as Sprite2D
@onready var machine := %StateMachine as StateMachine

# Player Specific, to be moved later
@onready var ground: GroundState = %StateMachine/Ground as GroundState
@onready var air: AirState = %StateMachine/Air as AirState
#@onready var fringe: FringeState = %StateMachine/Fringe as FringeState

var coyote_time_grounded: bool:
	get: return Time.get_ticks_msec() <= coyote_time_start + stats.coyote_time_ticks

var direction: Vector2
var coyote_time_start: int
var is_transition_blocked: bool:
	get: return machine.is_locked

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_time_start = Time.get_ticks_msec()
	direction = Input.get_vector("left", "right", "up", "down")
	if not is_transition_blocked:
		if air.should_jump or not is_on_floor():
			machine.set_state(air)
		else:
			machine.set_state(ground)

	machine.do(delta)

func release() -> void:
	machine.is_locked = false

func lock() -> void:
	machine.is_locked = true
