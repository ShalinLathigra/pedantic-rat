class_name State
extends StateMachine

@export var anim: String

func enter():
	core.animator.play(anim)
	print("entering state: " + name)

func exit() -> void:
	print("exiting state: " + name)
