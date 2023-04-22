class_name Stats
extends Resource

@export_category("Ground Statistics")
@export_range(0, 500, 1) var speed: int
@export_range(0, 500, 1) var jump_force: int

@export_category("Air Statistics")
@export_range(0, 5000, 1) var long_jump_max_ticks: int
@export var long_jump_curve: Curve
@export_range(0, 5000, 1) var short_jump_max_ticks: int
@export var short_jump_curve: Curve
