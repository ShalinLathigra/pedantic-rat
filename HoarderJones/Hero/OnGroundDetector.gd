extends Node2D

signal on_hit_ground
signal on_hit_ground_hard

@export var core: Character
@export_range(-50, 50) var max_volume_db: float
@export_range(-50, 50) var min_volume_db: float
@export_range(0, 1, 0.05) var hard_hit_threshold: float

@onready var audio_player := $OnGroundPlayer as AudioStreamPlayer2D

var on_floor_two_frames_ago: bool

var y_vel_graph: Array[float] = [0,0,0]
var max_y_vel: float
var current_ratio: float

func _ready() -> void:
	assert(core)
	await(core.ready)
	max_y_vel = core.stats.max_fall_rate_pixels

func _physics_process(_delta: float) -> void:

	# Calculate current y vel mapping
	y_vel_graph.pop_front()
	y_vel_graph.push_back(core.velocity.y)
	current_ratio = remap(max(y_vel_graph[0], 0), 0, max_y_vel, 0, 1)

	# Apply ratio
	audio_player.volume_db = current_ratio * max_volume_db

	# Calculate whether to emit on_hit_ground
	# Perform last second calls
	var on_floor_last_frame := core.is_on_floor()
	if on_floor_last_frame and not on_floor_two_frames_ago and not core.is_state_locked:
		on_hit_ground.emit()
		if current_ratio >= hard_hit_threshold:
			on_hit_ground_hard.emit()

	on_floor_two_frames_ago = on_floor_last_frame
