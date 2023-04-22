class_name State
extends StateMachine

@export var anim: String

var is_finished: bool

func enter():
	is_finished = false
	if anim != "":
		core.animator.play(anim)
	print("entering state: " + name)

func exit() -> void:
	is_finished = false
	print("exiting state: " + name)
