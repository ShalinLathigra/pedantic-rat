class_name ExtendableLadder2D
extends Area2D

signal on_anim_start

@export var extended: bool
@export var end_tile_size: Vector2
@export var start_tile_size: Vector2
@export var startup_delay: float
@export var tween_ease: Tween.EaseType
@export var tween_trans: Tween.TransitionType
@export_range(0.00, 2.50, 0.25) var open_time: float

@onready var sprite := $Sprite2D as Sprite2D

var tw: Tween

func _ready() -> void:
	sprite.size = end_tile_size if extended else start_tile_size

func toggle(_area: Area2D) -> void:
	if tw:
		tw.stop()
	extended = not extended
	tw = create_tween().set_ease(tween_ease).set_trans(tween_trans)
	tw.tween_interval(startup_delay)
	tw.tween_callback(func(): on_anim_start.emit())
	tw.tween_property(sprite, "size", end_tile_size if extended else start_tile_size, open_time)
