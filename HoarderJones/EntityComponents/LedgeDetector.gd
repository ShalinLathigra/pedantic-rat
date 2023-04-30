class_name LedgeDetector
extends Node2D

signal reached_grabbable_ledge

@export var core: Character
@onready var ledge_origin := $LedgeOrigin as ChildFlipper
@onready var high_checker := $LedgeOrigin/HighChecker as Area2D
@onready var low_checker := $LedgeOrigin/LowChecker as Area2D
@onready var ledge_state := $Ledge as LedgeGrabState

const RED := Color.RED
const GREEN := Color.FOREST_GREEN

var is_near_ledge: bool:
	get: return low_checker.has_overlapping_bodies() and not high_checker.has_overlapping_bodies()

var detect_edge_low: bool
var detect_edge_high: bool
var checker_offset: Vector2
var ledge_hang_offset: Vector2
var ledge_direction: Vector2

func _ready() -> void:
	checker_offset = ledge_origin.position
	ledge_state.core = core

func _process(_delta: float) -> void:
	# Adjust detector directions
	if core.direction_raw.x != 0 and not core.is_direction_locked:
		ledge_direction = Vector2.RIGHT * core.direction_raw.x
		ledge_origin.set_facing(core.direction_raw.x == 1)
		ledge_origin.position = Vector2(core.direction_raw.x * checker_offset.x, checker_offset.y)

	# Check if should update state
	if core.is_state_locked: return
	if not ledge_state.is_ready_to_reenter: return
	if is_near_ledge and core.velocity.y > 0 and not Input.is_action_pressed("down"):
		ledge_state.hanging_spot = find_hanging_spot()
		ledge_state.landing_pad = find_landing_pad()
		ledge_state.ledge_direction = ledge_direction
		core.machine.set_state(ledge_state)

func find_hanging_spot() -> Vector2:
	return World.find_tile_intersection_world(ledge_origin.global_position) - ledge_origin.position

func find_landing_pad() -> Vector2:
	return World.find_tile_intersection_world(ledge_origin.global_position) + ledge_direction * 2.0
