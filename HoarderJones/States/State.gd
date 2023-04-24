class_name State
extends StateMachine

signal finished
# TODO: Make this an array of strings, suffix looping anims with "LOOP"
# Should pass through
@export var anim: String

func enter():
	if anim != "":
		core.animator.stop()
		core.animator.play(anim)
	print("entering state: " + name)

func exit() -> void:
	if current:
		current.exit()
	current = null
	print("exiting state: " + name)
