class_name State
extends StateMachine

signal on_finished
signal on_entered
signal on_exited
# TODO: Make this an array of strings, suffix looping anims with "LOOP"
# Should pass through
@export var anim: String

const MIN_TICKS_TO_REENTRY := 250
var is_ready_to_reenter: bool:
	get: return Time.get_ticks_msec() > time_of_last_exit + MIN_TICKS_TO_REENTRY
var time_of_last_exit: int
var tween: Tween

func should_process() -> bool:
	return false

func enter():
	if anim != "":
		core.animator.stop()
		core.animator.play(anim)
		on_entered.emit()

func exit() -> void:
	time_of_last_exit = Time.get_ticks_msec()
	if current:
		current.exit()
	current = null
	on_exited.emit()
