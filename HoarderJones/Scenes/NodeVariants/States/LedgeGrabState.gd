class_name LedgeGrabState
extends State

@onready var detector := %LedgeDetector as LedgeDetector

var started_mantle_animation: bool
var exit_callable: Callable

func _ready() -> void:
	exit_callable = pre_exit.bind(true)

func should_process() -> bool:
	if not is_ready_to_reenter:
		return false
	if core.velocity.y < 0:
		return false
	if not detector.is_near_ledge:
		return false
	return core.direction_raw.y >= 0

func enter() -> void:
	super.enter()
	core.lock_components()
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position", detector.find_hanging_spot(), 0.25)
	core.velocity = Vector2.ZERO
	started_mantle_animation = false
#
func do(_delta: float) -> void:
	if InputManager.is_action_just_pressed("mantle") and not started_mantle_animation:
		var landing_pad = detector.find_landing_pad()
		started_mantle_animation = true
		if tween: tween.stop()
		tween = create_tween().set_parallel()
		tween.set_ease(Tween.EASE_IN) \
		.set_trans(Tween.TRANS_LINEAR)\
		.tween_property(core, "global_position:x", landing_pad.x, 0.5)
		tween.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_EXPO)\
		.tween_property(core, "global_position:y", landing_pad.y, 0.5)
		tween.chain().tween_callback(exit_callable)
	elif InputManager.is_action_just_pressed("drop") or InputManager.is_action_just_pressed("jump"):
		exit_callable.call()

func exit() -> void:
	super.exit()
