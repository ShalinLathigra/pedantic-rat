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
	if core.is_transition_blocked: return

	if core.direction.x < 0:
		ledge_origin.position = Vector2(-1 * checker_offset.x, checker_offset.y)
		ledge_origin.set_facing(false)
		ledge_direction = Vector2.LEFT
	if core.direction.x > 0:
		ledge_origin.position = checker_offset
		ledge_origin.set_facing(true)
		ledge_direction = Vector2.RIGHT

	if is_near_ledge and core.velocity.y > 0 and not Input.is_action_pressed("down"):
		core.machine.set_state(ledge_state)

func find_hanging_spot() -> Vector2:
	return World.find_tile_intersection(ledge_origin.global_position) - ledge_origin.position

func find_landing_pad() -> Vector2:
	return World.find_tile_intersection(ledge_origin.global_position) + ledge_direction * 2.0
