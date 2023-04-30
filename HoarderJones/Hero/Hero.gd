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

var coyote_time_grounded: bool:
	get: return Time.get_ticks_msec() <= coyote_time_start + stats.coyote_time_ticks

var direction: Vector2
var direction_raw: Vector2
var coyote_time_start: int
var is_state_locked: bool:
	get: return machine.is_locked
var is_direction_locked: bool

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_time_start = Time.get_ticks_msec()
	direction = InputManager.get_vector("left", "right", "up", "down")
	direction_raw.x = InputManager.get_axis("left", "right")
	direction_raw.y = InputManager.get_axis("up", "down")
	if not is_state_locked:
		if air.should_jump or not is_on_floor():
			machine.set_state(air)
		else:
			machine.set_state(ground)
	machine.do(delta)
	move_and_slide()

func release() -> void:
	machine.is_locked = false
	is_direction_locked = false

func lock_components(dir_lock: bool=true) -> void:
	machine.is_locked = true
	is_direction_locked = dir_lock
