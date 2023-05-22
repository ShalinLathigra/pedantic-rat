class_name AreaVisualizer2D
extends Sprite2D

@export var target: Area2D
@export var off := Color("b00000b5")
@export var on := Color("008700ab")
@export var target_bodies: bool

func _ready() -> void:
	assert(target != null)

func _process(_delta: float) -> void:
	if target_bodies:
		self.self_modulate = off if target.has_overlapping_bodies() else on
	else:
		self.self_modulate = off if target.has_overlapping_areas() else on
