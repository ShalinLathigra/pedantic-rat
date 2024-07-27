extends State

@export var action_name: StringName
@export_range(0, 10000, 100) var duration_seconds: int

var progress: float :
	get:
		return clamp(float(Time.get_ticks_msec() - start_tick) / duration_seconds, 0.0, 1.0)
var start_tick: int

func should_process() -> bool:
	if not is_ready_to_reenter:
		return false
	return InputManager.is_action_just_pressed(action_name) or InputManager.is_action_pressed(action_name)

func enter() -> void:
	super.enter()
	start_tick = Time.get_ticks_msec()

func do(_delta: float) -> void:
	pass
