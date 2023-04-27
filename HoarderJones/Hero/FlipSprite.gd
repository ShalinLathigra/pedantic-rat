extends Sprite2D

@export var core: Character

var left_held: bool
var right_held: bool

func _process(_delta: float) -> void:
	if not core.is_transition_blocked:
		if core.direction.x < 0:
			flip_h = true
			position.x = offset.x * -2
		if core.direction.x > 0:
			flip_h = false
			position.x = 0
