extends Node

var screen_mouse_position: Vector2
var world_mouse_position: Vector2
# Wrapper for Input, in future we may want to have a middle step to process inputs

func is_action_pressed (input_string: StringName) -> bool:
	return Input.is_action_pressed(input_string)

func is_action_just_pressed (input_string: StringName) -> bool:
	return Input.is_action_just_pressed(input_string)

func is_action_just_released (input_string: StringName) -> bool:
	return Input.is_action_just_released(input_string)

func get_axis (negative_action: StringName, positive_action: StringName) -> float:
	return Input.get_axis(negative_action, positive_action)

func get_axis_raw (negative_action: StringName, positive_action: StringName) -> float:
	return sign(Input.get_axis(negative_action, positive_action))

func get_vector (negative_x: StringName, positive_x: StringName, negative_y: StringName, positive_y: StringName, deadzone: float = -1.0) -> Vector2:
	return Input.get_vector(negative_x, positive_x, negative_y, positive_y, deadzone)

func get_vector_raw (negative_x: StringName, positive_x: StringName, negative_y: StringName, positive_y: StringName, deadzone: float = -1.0) -> Vector2:
	var vector := Input.get_vector(negative_x, positive_x, negative_y, positive_y, deadzone)
	return Vector2(sign(vector.x), sign(vector.y))

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var pos = event.global_position
		screen_mouse_position = pos
		pos.x = remap(pos.x, \
			0, ProjectSettings.get_setting("display/window/size/window_width_override"), \
			0, ProjectSettings.get_setting("display/window/size/viewport_width"))
		pos.y = remap(pos.y, \
			0, ProjectSettings.get_setting("display/window/size/window_height_override"), \
			0, ProjectSettings.get_setting("display/window/size/viewport_height"))
		world_mouse_position = pos
