class_name LadderClimbState
extends State


var speed: int:
	get: return core.stats.climb_speed

var snap_point: Vector2
@onready var detector := %LadderDetector as LadderDetector

func should_process() -> bool:
	if not is_ready_to_reenter:
		return false
	if not detector.core_covered:
		return false
	if core.direction_raw.y == 0:
		return false
	snap_point = World.find_nearest_ladder_center(core.global_position)
	var to_snap_point = core.global_position.direction_to(snap_point)
	return sign(to_snap_point.x) == sign(core.direction_raw.x) or core.direction_raw.x == 0

func enter() -> void:
	super.enter()
	core.lock_components(false)
	core.velocity = Vector2.ZERO
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position:x", snap_point.x, 0.125)

func do(_delta) -> void:
	# Handle Mantle Ladder logic
	if detector.at_top_of_ladder and InputManager.is_action_just_pressed("mantle"):
		if tween: tween.stop()
		tween = create_tween().set_parallel()
		snap_point = World.find_highest_ladder_center(core.global_position) + Vector2.DOWN * (World.TILE_SIZE / 2.0 - 1)
		tween.tween_property(core, "global_position:y", snap_point.y, 0.25)
		tween.tween_callback(core.release)
	# Other Ladder Exit logic
	elif InputManager.is_action_just_pressed("jump") \
		or InputManager.is_action_just_pressed("drop") \
		or (detector.at_ladder_ground and abs(core.direction.x) > core.stats.threshold and core.direction.y > 0) \
		or (detector.at_bottom_of_ladder and InputManager.is_action_just_pressed("down")):
		core.release()
	# Ladder movement and animation logic
	if detector.can_climb_in_direction(core.direction_raw):
		if not core.animator.is_playing():
			core.animator.play()
		core.velocity.y = core.direction_raw.y * speed
	else:
		if core.animator.is_playing():
			core.animator.pause()
		core.velocity.y = 0

func exit() -> void:
	super.exit()
	core.release()

