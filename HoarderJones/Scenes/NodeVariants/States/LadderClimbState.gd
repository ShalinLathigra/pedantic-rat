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
	if InputManager.is_action_just_pressed("space") or ladder_detector.at_climb_bottom:
		core.release()
	if ladder_detector.at_climb_top and InputManager.is_action_pressed("up"):
		if tween: tween.stop()
		tween = create_tween().set_parallel()
		snap_point = World.find_highest_ladder_center(core.global_position) + Vector2.DOWN * (World.TILE_SIZE / 2 - 1)
		tween.tween_property(core, "global_position:y", snap_point.y, 0.25)
		tween.tween_callback(core.release)
	if ladder_detector.can_climb_in_direction(core.direction_raw):
		core.velocity.y = core.direction_raw.y * speed
	else:
		core.velocity.y = 0

func exit() -> void:
	super.exit()
	core.release()
