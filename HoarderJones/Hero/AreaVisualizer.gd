extends Sprite2D

@export var target: Area2D
@export var off: Color
@export var on: Color
@export var target_bodies: bool

func _ready() -> void:
	assert(target != null)

func _process(delta: float) -> void:
	if target_bodies:
		self.self_modulate = off if target.has_overlapping_bodies() else on
	else:
		self.self_modulate = off if target.has_overlapping_areas() else on
