class_name Character
extends CharacterBody2D
# needs to have a custom stats object

# Core Character Components
@export var stats: Stats
@onready var shape := %CollisionShape2D.shape as RectangleShape2D
@onready var animator := %Animator as AnimationPlayer
@onready var sprite := %Sprite as Sprite2D
@onready var machine := %PlayerBrain as StateMachine
# exported to expose to animator
@export var can_early_exit: bool

# Player Specific
var coyote_time_grounded: bool:
	get: return Time.get_ticks_msec() <= coyote_time_start + stats.coyote_time_ticks

var direction: Vector2
var direction_raw: Vector2
var facing: Vector2 = Vector2.RIGHT

var is_state_locked: bool:
	get: return machine.is_locked
var is_direction_locked: bool

# Player Specific
var coyote_time_start: int

func _ready() -> void:
	machine.startup()

func _physics_process(delta: float) -> void:
	if is_on_floor():
		coyote_time_start = Time.get_ticks_msec()

	if not is_direction_locked:
		direction = InputManager.get_vector("left", "right", "up", "down")
		direction_raw = InputManager.get_vector_raw("left", "right", "up", "down", 0.5)
		if direction_raw.x != 0:
			facing.x = direction_raw.x

	machine.do(delta)
	move_and_slide()

func release() -> void:
	machine.is_locked = false
	is_direction_locked = false

func lock_components(dir_lock: bool=true) -> void:
	machine.is_locked = true
	is_direction_locked = dir_lock
