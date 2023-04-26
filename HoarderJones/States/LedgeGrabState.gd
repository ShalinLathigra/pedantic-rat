class_name LedgeGrabState
extends State

@onready var ledge_detector := %LedgeDetector as LedgeDetector

const TICKS_BETWEEN_LEDGE_GRABS := 250

var is_ready_to_process_ledge: bool:
	get: return Time.get_ticks_msec() > time_of_last_ledge_grab + TICKS_BETWEEN_LEDGE_GRABS

var time_of_last_ledge_grab: int

func enter() -> void:
	super.enter()
	var clamped_direction = Vector2.RIGHT * sign(core.direction.x)
	core.global_translate(ledge_detector.find_hanging_spot() - core.global_position)
	core.velocity = Vector2.ZERO
	core.lock()
#
func do(_delta: float) -> void:
	if Input.is_action_just_released("down") or (Input.is_action_just_pressed("space") and core.direction != ledge_detector.ledge_direction):
		core.release()
	if Input.is_action_just_released("up"):
		core.global_translate(ledge_detector.find_landing_pad() - core.global_position)
		core.release()

func exit() -> void:
	super.exit()
	time_of_last_ledge_grab = Time.get_ticks_msec()
