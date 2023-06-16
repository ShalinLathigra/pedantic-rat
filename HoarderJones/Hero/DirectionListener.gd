extends Node

@export var core: Character

func _ready() -> void:
	assert(core)

func _process(_delta: float) -> void:
	if not core.is_direction_locked:
		core.direction = InputManager.get_vector("left", "right", "up", "down")
		core.direction_raw = InputManager.get_vector_raw("left", "right", "up", "down", 0.5)
		if core.direction_raw.x != 0:
			core.facing.x = core.direction_raw.x
