extends Node

# Wrapper for Input, in future we may want to have a middle step to process inputs

func is_action_pressed (str: StringName) -> bool:
	return Input.is_action_pressed(str)

func is_action_just_pressed (str: StringName) -> bool:
	return Input.is_action_just_pressed(str)

func is_action_just_released (str: StringName) -> bool:
	return Input.is_action_just_released(str)

func get_axis (negative_action: StringName, positive_action: StringName) -> float:
	return Input.get_axis(negative_action, positive_action)

func get_vector (negative_x: StringName, positive_x: StringName, negative_y: StringName, positive_y: StringName, deadzone: float = -1.0) -> Vector2:
	return Input.get_vector(negative_x, positive_x, negative_y, positive_y, deadzone)
