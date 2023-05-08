extends Node

@export var core: Character

signal on_hit_ground
var on_floor_two_frames_ago: bool

func _ready() -> void:
	assert(core)

func _physics_process(_delta: float) -> void:
	var on_floor_last_frame := core.is_on_floor()
	if on_floor_last_frame and not on_floor_two_frames_ago and not core.is_state_locked:
		on_hit_ground.emit()

	on_floor_two_frames_ago = on_floor_last_frame
