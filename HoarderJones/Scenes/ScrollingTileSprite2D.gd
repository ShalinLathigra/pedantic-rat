@tool
extends Sprite2D

signal on_sprite_updated

@export var base_rect: Vector2 = Vector2(16, 16)
@export var scroll_direction := Vector2.DOWN
@export var size: Vector2:
	set(value):
		size = value
		region_rect.size = Vector2(base_rect.x * size.x, base_rect.y * size.y)
		offset = 0.5 * Vector2(scroll_direction.x * region_rect.size.x, scroll_direction.y * region_rect.size.y)
		on_sprite_updated.emit()
