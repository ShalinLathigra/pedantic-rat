class_name RegionTrackingRectangleShape2D
extends CollisionShape2D

@export var target: Sprite2D

func _ready () -> void:
	await target.ready
	var rect_shape = shape as RectangleShape2D
	rect_shape.size = target.region_rect.size
	position = rect_shape.size * 0.5
