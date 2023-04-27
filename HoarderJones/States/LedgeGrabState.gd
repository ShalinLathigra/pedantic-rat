class_name LedgeGrabState
extends State

@onready var ledge_detector := %LedgeDetector as LedgeDetector

const TICKS_BETWEEN_LEDGE_GRABS := 250

var is_ready_to_process_ledge: bool:
	get: return Time.get_ticks_msec() > time_of_last_ledge_grab + TICKS_BETWEEN_LEDGE_GRABS

var time_of_last_ledge_grab: int
var started_mantle_animation: bool
var tween: Tween

func enter() -> void:
	super.enter()
	core.lock()
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position", ledge_detector.find_hanging_spot(), 0.25)
	core.velocity = Vector2.ZERO
	started_mantle_animation = false
#
func do(_delta: float) -> void:
	if Input.is_action_just_pressed("down") or (Input.is_action_just_pressed("space") and core.direction != ledge_detector.ledge_direction):
		core.release()
	if Input.is_action_just_pressed("up") and not started_mantle_animation:
		started_mantle_animation = true
		if tween: tween.stop()
		tween = create_tween().set_parallel()
		var pad = ledge_detector.find_landing_pad()
		tween.set_ease(Tween.EASE_IN) \
		.set_trans(Tween.TRANS_LINEAR)\
		.tween_property(core, "global_position:x", pad.x, 0.5)
		tween.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_EXPO)\
		.tween_property(core, "global_position:y", pad.y, 0.5)
		tween.chain().tween_callback(core.release)

func exit() -> void:
	super.exit()
	time_of_last_ledge_grab = Time.get_ticks_msec()
