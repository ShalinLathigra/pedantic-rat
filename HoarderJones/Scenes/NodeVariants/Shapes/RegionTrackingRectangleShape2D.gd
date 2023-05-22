class_name SpriteTrackingRectangleShape2D
extends CollisionShape2D

@export var target: Sprite2D
@onready var rect_shape = shape as RectangleShape2D

func _ready () -> void:
	await target.ready
	update()

func update() -> void:
	if target.region_enabled:
		rect_shape.size = target.region_rect.size
	else:
		rect_shape.size = target.texture.get_size()
		rect_shape.size.x *= target.scale.x
		rect_shape.size.y *= target.scale.y
	position = target.offset * target.scale.y
