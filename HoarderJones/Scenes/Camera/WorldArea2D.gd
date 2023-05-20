@tool
class_name WorldArea2D
extends ShapeWrapper2D

signal on_entered
signal on_exited

@export var zoom: float = 1

var core: Character
var is_occupied: bool
# Emit a signal when/if the player is inside this object

func _ready() -> void:
	assert(zoom > 0)

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


# Need to determine coverage of player. Whichever thing is most covering the player's direction or whatever,
# have the camera locke on to that one.
# Therefore we need some sort of room manager which is responsible for deciding which room is which, and
# which the camera should focus on.
# Possibly a "peep" mode? Turn rooms into a graph allowing you to see which lanes the player is able to peep into.
