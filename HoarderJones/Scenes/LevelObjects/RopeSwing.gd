class_name RopeSwing
extends Area2D

signal on_reached_peak

@export var suffix: StringName
@onready var player := $AnimationPlayer as AnimationPlayer
@onready var hang_point := $HangPoint as Node2D

var direction: Vector2

func _ready() -> void:
	assert(hang_point)

func emit_on_reached_peak() -> void:
	on_reached_peak.emit()

func trigger_rope_swing(origin_position: Vector2) -> void:
	if player.is_playing(): return
	if origin_position.x < global_position.x:
		player.play("SwingRight" + suffix)
		direction = Vector2.RIGHT
	else:
		player.play("SwingLeft" + suffix)
		direction = Vector2.LEFT
