class_name RopeSwingDetector
extends Node2D

@export var core: Character
@onready var rope_swing_state := $RopeSwingState as RopeSwingState

func _ready() -> void:
	rope_swing_state.core = core

func on_rope_checker_area_entered(area: Area2D) -> void:
	print("Here")
	if not area is RopeSwing: return
	rope_swing_state.rope = area as RopeSwing
	core.machine.set_state(rope_swing_state)
