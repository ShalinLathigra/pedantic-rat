class_name LedgeDetector
extends Node2D

@export var core: Character
@onready var ledge_origin := $LedgeOrigin as ChildFlipper
@onready var high_checker := $LedgeOrigin/HighChecker as Area2D
@onready var low_checker := $LedgeOrigin/LowChecker as Area2D

var is_near_ledge: bool:
	get: return low_checker.has_overlapping_bodies() and not high_checker.has_overlapping_bodies()

var detect_edge_low: bool
var detect_edge_high: bool
var checker_offset: Vector2
var ledge_hang_offset: Vector2
var ledge_direction: Vector2

func _ready() -> void:
	assert(core)
	checker_offset = ledge_origin.position

func _process(_delta: float) -> void:
	# Adjust detector directions
	if not core.is_direction_locked:
		ledge_direction = Vector2.RIGHT * core.facing.x
		ledge_origin.set_facing(core.facing.x == 1)
		ledge_origin.position = Vector2(core.facing.x * checker_offset.x, checker_offset.y)

func find_hanging_spot() -> Vector2:
	return World.find_tile_intersection_world(ledge_origin.global_position) - ledge_origin.position

func find_landing_pad() -> Vector2:
	return World.find_tile_intersection_world(ledge_origin.global_position) + ledge_direction * 2.0
