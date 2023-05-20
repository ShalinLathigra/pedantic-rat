extends Sprite2D

@export var core: Character

func _process(_delta: float) -> void:
	if core.is_direction_locked: return
	flip_h = core.facing == Vector2.LEFT
	position.x = offset.x * (-1 + core.facing.x)
