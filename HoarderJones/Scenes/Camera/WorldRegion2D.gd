@tool
class_name WorldArea2D
extends Marker2D

signal on_entered
signal on_exited

@export var size: Vector2:
	set(value):
		size = value
		queue_redraw()
@export var debug_colour := Color("0099b36b") :
	set(value):
		debug_colour = value
		queue_redraw()

@onready var rect := Rect2(global_position - size * 0.5, size)

var core: Character
var is_occupied: bool
# Emit a signal when/if the player is inside this object

func _draw() -> void:
	if Engine.is_editor_hint():
		draw_rect(Rect2(size * -0.5, size), debug_colour, true)

func _process(_delta: float) -> void:
	if not core:
		return
	var core_present = rect.has_point(core.global_position)
	if is_occupied and not core_present:
		on_exited.emit()
	elif not is_occupied and core_present:
		on_entered.emit()

	is_occupied = core_present
