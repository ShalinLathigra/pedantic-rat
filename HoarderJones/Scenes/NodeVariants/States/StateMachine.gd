class_name StateMachine
extends Node2D

@export var core: Character

signal locked()
signal released()

var current: State
var is_locked: bool

func _ready():
	for child in get_child_states():
		if not child is StateMachine:
			continue
		var machine := child as StateMachine
		machine.locked.connect(lock)
		machine.released.connect(release)

	if core == null:
		return
	var state_descendents: Array[StateMachine] = get_child_states_recursive()
	for state in state_descendents:
		state.core = core

func get_child_states() -> Array[State]:
	var state_set: Array[State] = []
	var children = get_children().filter(func (child): return child is State)
	for child in children:
		state_set.push_back(child as State)
	return state_set

func get_child_states_recursive() -> Array[StateMachine]:
	# Get children
	var direct_children = get_children().filter(func(child): return child is StateMachine)
	# if lowest child, return self
	if direct_children.size() == 0:
		return [self as StateMachine]
	# otherwise, return self, all lowest children
	var ret: Array[StateMachine] = [self as StateMachine]
	for child in direct_children:
		ret.append_array(child.get_child_states_recursive())
	return ret

func do(delta: float) -> void:
	if current:
		current.do(delta)

func set_state(target: State, override: bool = false) -> void:
	if is_locked:
		return
	if target == current and not override:
		return
	if current:
#		prints("exiting state: ", current.name)
		current.exit()
	current = target
#	prints("entering state:", current.name, current is State)
	current.enter()

func lock() -> void:
	is_locked = true
	locked.emit()

func release() -> void:
	is_locked = false
	released.emit()
