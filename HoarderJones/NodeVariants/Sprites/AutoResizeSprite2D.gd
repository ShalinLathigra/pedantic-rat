class_name AutoResizeSprite2D
extends Sprite2D

func _ready() -> void:
	region_rect.size.x *= scale.x
	region_rect.size.y *= scale.y
	scale = Vector2.ONE
