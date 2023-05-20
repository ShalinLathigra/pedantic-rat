@tool
class_name ShapeWrapper2D
extends Marker2D

@export var size: Vector2:
	set(value):
		size = value
		queue_redraw()
@export var randomize_colour := false:
	set(_value):
		debug_colour = Color(randf(), randf(), randf(), debug_colour.a)
@export var debug_colour := Color("0099b36b") :
	set(value):
		debug_colour = value
		queue_redraw()

@onready var rect := Rect2(global_position - size * 0.5, size)

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(size * -0.5, size), debug_colour, true)
