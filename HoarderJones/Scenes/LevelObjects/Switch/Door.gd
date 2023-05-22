extends AnimatableBody2D

signal on_anim_start
signal on_anim_end

@export var open: bool
@export var open_tile_offset: Vector2
@export var tween_ease: Tween.EaseType
@export var tween_trans: Tween.TransitionType
@export_range(0.00, 2.50, 0.25) var open_time: float

var tw: Tween
var close_pos: Vector2
var open_pos: Vector2

func _ready() -> void:
	close_pos = global_position
	open_pos = close_pos + open_tile_offset * World.TILE_SIZE
	if open:
		global_position = open_pos

func toggle_state(_area: Area2D) -> void:
	open = not open
	if tw:
		tw.stop()
	tw = create_tween().set_ease(tween_ease).set_trans(tween_trans)
	tw.tween_interval(0.25)
	tw.tween_callback(func(): on_anim_start.emit())
	tw.tween_interval(0.25)
	tw.tween_property(self, "global_position", open_pos if open else close_pos, open_time)
	tw.tween_callback(func(): on_anim_end.emit())
