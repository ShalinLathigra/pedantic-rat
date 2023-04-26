class_name LedgeDetector
extends Node2D

signal reached_grabbable_ledge

@export var core: Character
@onready var ledge_origin := $LedgeOrigin as ChildFlipper
@onready var high_checker := $LedgeOrigin/HighChecker as Area2D
@onready var low_checker := $LedgeOrigin/LowChecker as Area2D
@onready var high_visualizer := $LedgeOrigin/HighChecker/Sprite2D as Sprite2D
@onready var low_visualizer := $LedgeOrigin/LowChecker/Sprite2D as Sprite2D
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
	if not core.is_transition_blocked:
		if core.direction == Vector2.LEFT:
			ledge_origin.position = Vector2(-1 * checker_offset.x, checker_offset.y)
			ledge_origin.set_facing(false)
			ledge_direction = Vector2.LEFT
		if core.direction == Vector2.RIGHT:
			ledge_origin.position = checker_offset
			ledge_origin.set_facing(true)
			ledge_direction = Vector2.RIGHT

		if is_near_ledge and core.velocity.y > 0:
			core.machine.set_state(ledge_state)

func find_ledge_point() -> Vector2:
	var ledge_point = Vector2()
	ledge_point.x = snappedi(ledge_origin.global_position.x, World.TILE_SIZE.x)
	var offset = (low_checker.position.y - high_checker.position.y) / 2.0
	ledge_point.y = snappedi(ledge_origin.global_position.y + offset, World.TILE_SIZE.y)
	return ledge_point

func find_hanging_spot() -> Vector2:
	return find_ledge_point() - ledge_origin.position

func find_landing_pad() -> Vector2:
	return find_ledge_point() + ledge_direction * 2.0

func _on_checker_body_entered(_body: Node2D, is_high: bool) -> void:
	if is_high:
		detect_edge_high = true
		high_visualizer.self_modulate = RED
	else:
		detect_edge_low = true
		low_visualizer.self_modulate = RED

func _on_checker_body_exited(_body: Node2D, is_high: bool) -> void:
	if is_high:
		detect_edge_high = false
		high_visualizer.self_modulate = GREEN
	else:
		detect_edge_low = false
		low_visualizer.self_modulate = GREEN
