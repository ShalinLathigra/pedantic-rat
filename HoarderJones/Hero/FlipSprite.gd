extends Sprite2D

@export var core: Character

var left_held: bool
var right_held: bool

func _process(delta: float) -> void:
	if core.direction == Vector2.LEFT:
		flip_h = true
		position.x = offset.x * -2
	if core.direction == Vector2.RIGHT:
		flip_h = false
		position.x = 0
