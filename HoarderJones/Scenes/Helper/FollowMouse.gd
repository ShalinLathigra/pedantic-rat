extends Node2D

func _process(_delta: float) -> void:
	global_position = InputManager.world_mouse_position
