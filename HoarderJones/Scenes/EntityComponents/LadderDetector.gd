class_name LadderDetector
extends Node2D

@export var core: Character
@onready var ladder_checker := $LadderChecker as Area2D
@onready var ascent_checker := $AscentChecker as Area2D
@onready var descent_checker := $DescentChecker as Area2D
@onready var ladder_state := $LadderClimb as LadderClimbState
@onready var ground_ray := $GroundRaycast as RayCast2D

var core_covered : bool:
	get: return ladder_checker.has_overlapping_bodies()

var ascent_covered : bool:
	get: return ascent_checker.has_overlapping_bodies()

var descent_covered : bool:
	get: return descent_checker.has_overlapping_bodies()

var at_ladder_ground: bool:
	get: return ground_ray.is_colliding()

var at_bottom_of_ladder: bool:
	get: return core_covered and not ascent_covered

var at_top_of_ladder: bool:
	get: return core_covered and not descent_covered

func _ready() -> void:
	ladder_state.core = core

func _process(_delta: float) -> void:
	# Check if should transition to state
	print(ground_ray.is_colliding())
	if core.is_state_locked: return
	if not ladder_state.is_ready_to_reenter: return
	if not core_covered: return
	if not (Input.is_action_pressed("up") or Input.is_action_pressed("down")): return
	var snap_point := World.find_nearest_ladder_center(global_position)
	var to_snap_point = global_position.direction_to(snap_point)
	if sign(to_snap_point.x) == sign(core.direction_raw.x) or core.direction_raw.x == 0:
		ladder_state.snap_point = snap_point
		core.machine.set_state(ladder_state)

func can_climb_in_direction(direction: Vector2) -> bool:
	if direction.y > 0:
		return ascent_covered and core_covered
	if direction.y < 0:
		return descent_covered and core_covered
	return false
