class_name LadderClimbState
extends State

@onready var ladder_detector := %LadderDetector as LadderDetector

var speed: int:
	get: return core.stats.climb_speed

var tween: Tween
var snap_point: Vector2

func enter() -> void:
	super.enter()
	core.lock_components(false)
	core.velocity = Vector2.ZERO
	if tween: tween.stop()
	tween = create_tween().set_parallel()
	tween.tween_property(core, "global_position:x", snap_point.x, 0.125)

func do(_delta) -> void:
	if Input.is_action_just_pressed("space") or ladder_detector.at_climb_bottom:
		core.release()

	self.core.velocity.y = core.direction_raw.y * speed
	if ladder_detector.can_climb_in_direction(core.direction_raw):
		self.core.move_and_slide()

func exit() -> void:
	super.exit()
	core.release()
