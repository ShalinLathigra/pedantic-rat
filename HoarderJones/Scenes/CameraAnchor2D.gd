@tool
extends ShapeWrapper2D
class_name CameraAnchor2D

@export var zoom: int = 1
var core: Character
var is_occupied: bool

signal on_entered

func _ready() -> void:
	# ensure core exists
	await(owner.ready)
	assert(core)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	on_entered.emit()
