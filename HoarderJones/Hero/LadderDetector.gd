extends Node2D

@export var core: Character
@onready var ladder_checker := $LadderChecker as Area2D
@onready var ladder_state := $LadderClimb as LadderClimbState

func _ready() -> void:
	ladder_state.core = core

func _process(_delta: float) -> void:
	if core.is_transition_blocked: return
	if ladder_checker.has_overlapping_bodies() and \
		(Input.is_action_pressed("up") or Input.is_action_pressed("down")):
		core.machine.set_state(ladder_state)
