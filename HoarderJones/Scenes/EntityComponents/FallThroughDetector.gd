class_name FallThroughDetector
extends Node

@export var core: Character

func _unhandled_input(event: InputEvent) -> void:
	if not event.is_action_pressed("down"): return
	if not core.is_on_floor() or core.is_state_locked: return
	core.position += Vector2.DOWN
