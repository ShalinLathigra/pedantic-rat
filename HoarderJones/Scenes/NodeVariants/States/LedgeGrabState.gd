class_name LedgeGrabState
extends State

var hanging_spot: Vector2
var landing_pad: Vector2
var ledge_direction: Vector2

var started_mantle_animation: bool

func enter() -> void:
	super.enter()
	core.lock_components()
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position", hanging_spot, 0.25)
	core.velocity = Vector2.ZERO
	started_mantle_animation = false
#
func do(_delta: float) -> void:
	if InputManager.is_action_just_pressed("mantle") and not started_mantle_animation:
		started_mantle_animation = true
		if tween: tween.stop()
		tween = create_tween().set_parallel()
		tween.set_ease(Tween.EASE_IN) \
		.set_trans(Tween.TRANS_LINEAR)\
		.tween_property(core, "global_position:x", landing_pad.x, 0.5)
		tween.set_ease(Tween.EASE_OUT) \
		.set_trans(Tween.TRANS_EXPO)\
		.tween_property(core, "global_position:y", landing_pad.y, 0.5)
		tween.chain().tween_callback(core.release)
	elif InputManager.is_action_just_pressed("drop") or InputManager.is_action_just_pressed("jump"):
		core.release()

func exit() -> void:
	super.exit()
