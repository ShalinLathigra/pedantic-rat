class_name LadderClimbState
extends State

var tween: Tween

func enter() -> void:
	super.enter()
	core.lock()
	core.velocity = Vector2.ZERO
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position", World.find_nearest_half_tile(core.global_position), 0.125)
#
func exit() -> void:
	super.exit()
	core.release()
