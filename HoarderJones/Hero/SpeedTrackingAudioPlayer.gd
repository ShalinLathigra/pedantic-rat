extends AudioStreamPlayer2D

@export var core: Character
@export_range(-50, 50) var max_volume_db: float
@export_range(-50, 50) var min_volume_db: float
var y_vel_graph: Array[float] = [0,0,0]
var max_y_vel: float

func _ready() -> void:
	assert(core)
	await(core.ready)
	max_y_vel = core.stats.max_fall_rate_pixels


func _physics_process(_delta: float) -> void:
	y_vel_graph.pop_front()
	y_vel_graph.push_back(core.velocity.y)

	volume_db = remap(max(y_vel_graph[0], 0), 0, max_y_vel, min_volume_db, max_volume_db)
