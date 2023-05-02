class_name ChildFlipper
extends Node2D

var descendents: Array[Node2D]

var offsets: Array[Vector2]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if not child is Node2D: return
		descendents.push_back(child)
		offsets.push_back(child.position)

func set_facing(toRight: bool):
	for i in range(descendents.size()):
		if toRight:
			descendents[i].position = offsets[i]
		else:
			descendents[i].position = Vector2(-1 * offsets[i].x, offsets[i].y)
