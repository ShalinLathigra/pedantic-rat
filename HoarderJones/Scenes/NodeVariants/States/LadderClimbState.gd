class_name LadderClimbState
extends State


var speed: int:
	get: return core.stats.climb_speed

var tween: Tween
var snap_point: Vector2
var ladder_detector: LadderDetector

func _ready() -> void:
	await owner.ready
	assert(owner is LadderDetector)
	ladder_detector = owner

func enter() -> void:
	super.enter()
	core.lock_components(false)
	core.velocity = Vector2.ZERO
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position:x", snap_point.x, 0.125)

func do(_delta) -> void:
	if InputManager.is_action_just_pressed("space") or (ladder_detector.at_ladder_ground and core.direction_raw.x != 0) or (ladder_detector.at_bottom_of_ladder and InputManager.is_action_just_pressed("down")):
		core.release()
	if ladder_detector.at_top_of_ladder and InputManager.is_action_just_pressed("up"):
		if tween: tween.stop()
		tween = create_tween().set_parallel()
		snap_point = World.find_highest_ladder_center(core.global_position) + Vector2.DOWN * (World.TILE_SIZE / 2.0 - 1)
		tween.tween_property(core, "global_position:y", snap_point.y, 0.25)
		tween.tween_callback(core.release)
	if ladder_detector.can_climb_in_direction(core.direction_raw):
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
