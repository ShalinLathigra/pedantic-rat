extends Node2D

signal reached_grabbable_ledge

@export var core: Character
@onready var high_checker := $HighChecker as Area2D
@onready var low_checker := $LowChecker as Area2D
@onready var high_visualizer := $HighChecker/Sprite2D as Sprite2D
@onready var low_visualizer := $LowChecker/Sprite2D as Sprite2D

const RED := Color.RED
const GREEN := Color.FOREST_GREEN

var near_ledge: bool:
	get: return detect_edge_low and not detect_edge_high

var detect_edge_low: bool
var detect_edge_high: bool
var offset: Vector2

func _ready() -> void:
	offset = position

func _process(_delta: float) -> void:
	if not core.is_transition_blocked:
		if core.direction == Vector2.LEFT:
			position = Vector2(-1 * offset.x, offset.y)
		if core.direction == Vector2.RIGHT:
			position = offset

func _physics_process(_delta: float) -> void:
	if near_ledge: reached_grabbable_ledge.emit()

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
