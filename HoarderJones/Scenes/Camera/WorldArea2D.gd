@tool
class_name WorldArea2D
extends ShapeWrapper2D

var core: Character
var is_occupied: bool:
	get:
		return rect.has_point(core.global_position)

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(size * -0.5, size), debug_colour, true)
