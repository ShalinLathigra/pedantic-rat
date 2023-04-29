extends Sprite2D

@export var core: Character

var left_held: bool
var right_held: bool

func _process(_delta: float) -> void:
	if core.is_direction_locked: return
	if core.direction_raw.x == 0: return
	flip_h = core.direction_raw.x == -1
	position.x = offset.x * (-1 + core.direction_raw.x)
