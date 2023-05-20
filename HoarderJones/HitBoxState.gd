class_name HitBoxState
extends State

@export var flippable: bool
@export var hitbox: CollisionShape2D

@onready var hitbox_rect := hitbox.shape as RectangleShape2D
@onready var shape_args := $ShapeWrapper2D as ShapeWrapper2D

func enter() -> void:
	super.enter()
	hitbox.position.x = shape_args.position.x * core.facing.x
	hitbox.position.y = shape_args.position.y
	hitbox_rect.size = shape_args.size
