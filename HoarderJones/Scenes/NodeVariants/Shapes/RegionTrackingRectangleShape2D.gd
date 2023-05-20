class_name SpriteTrackingRectangleShape2D
extends CollisionShape2D

@export var target: Sprite2D

func _ready () -> void:
	await target.ready
	var rect_shape = shape as RectangleShape2D
	if target.region_enabled:
		rect_shape.size = target.region_rect.size
	else:
		rect_shape.size = target.texture.get_size()
		rect_shape.size.x *= target.scale.x
		rect_shape.size.y *= target.scale.y
	position = target.offset * target.scale.y

	# offset = 0, -64
	# scale = 0.125, 0.25
	# size = 128, 128
	#

	# expected size = 16,32
	# expected location = 0, -16
