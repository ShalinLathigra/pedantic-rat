class_name Stats
extends Resource

@export_subgroup("Ground Statistics")
@export_range(0, 64, 4) var run_speed: int
@export_range(0, 256, 4) var acc_rate: int
@export_range(0, 256, 4) var brake_speed: int

# Time to max elevation
@export_subgroup("Air Statistics")
@export_range(0, 64, 4) var air_speed: int
@export_range(0, 256, 4) var air_acc_rate: int
@export_range(0, 256, 4) var air_brake_speed: int
@export_subgroup("Jump Statistics")
@export var jump_curve: Curve
@export_range(0, 64, 2) var jump_max_height_pixels: int
@export_range(0, 2500, 50) var jump_max_ticks: int
@export_range(0, 2500, 50) var jump_min_ticks: int
@export_subgroup("Jump Control Statistics")
@export_range(0, 500, 50) var jump_buffer_ticks: int
@export_range(0, 500, 50) var coyote_time_ticks: int

# Time vs max fall speed
@export_subgroup("Fall Statistics")
@export var fall_curve: Curve
@export_range(0, 256, 4) var max_fall_rate_pixels: int
@export_range(0, 2500, 50) var ticks_to_max_fall_rate: int

@export_subgroup("Climb Statistics")
@export_range(0, 64, 4) var climb_speed: int

@export_subgroup("Rope Swing Statistics")
@export_range(0, 128, 4) var rope_swing_speed: int
