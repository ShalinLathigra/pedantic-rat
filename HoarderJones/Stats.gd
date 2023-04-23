class_name Stats
extends Resource

@export_category("Ground Statistics")
@export_range(0, 500, 1) var speed: int

# TODO: Make all of these + speed relative to the default tile size in some
# global settings object

# Time to max elevation
@export_category("Jump Statistics")
@export var jump_curve: Curve
@export_range(0, 128, 4) var jump_max_height_pixels: int
@export_range(0, 2500, 50) var jump_max_ticks: int
@export_range(0, 2500, 50) var jump_min_ticks: int
@export_category("Expanded Jump Statistics")
@export_range(0, 500, 50) var jump_buffer_ticks: int
@export_range(0, 500, 50) var coyote_time_ticks: int

# Time vs max fall speed
@export_category("Fall Statistics")
@export var fall_curve: Curve
@export_range(0, 256, 4) var max_fall_rate_pixels: int
@export_range(0, 2500, 50) var ticks_to_max_fall_rate: int
