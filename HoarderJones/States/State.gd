class_name State
extends StateMachine

# TODO: Make this an array of strings, suffix looping anims with "LOOP"
# Should pass through
@export var anim: String

var is_finished: bool

func enter():
	is_finished = false
	if anim != "":
		core.animator.stop()
		core.animator.play(anim)
#	print("entering state: " + name)

func exit() -> void:
	is_finished = false
	if current:
		current.exit()
	current = null
#	print("exiting state: " + name)
