class_name RopeSwingState
extends State

@onready var detector := $RopeSwingDetector as RopeSwingDetector

var rope: RopeSwing

func should_process() -> bool:
	if not is_ready_to_reenter:
		return false
	if not detector.is_covered:
		return false
	rope = detector.rope
	return true

func enter() -> void:
	super.enter()
	assert(rope)
	# TODO: If this is better, switch it over. I like facing though.
#	if core.velocity.x != 0:
#		rope.trigger_rope_swing(core.velocity)
#	else:
#		rope.trigger_rope_swing(core.facing)
	rope.trigger_rope_swing(core.facing)
	core.lock_components(true)
	core.velocity = Vector2.ZERO
	# Hack to ensure that the rope state exits on time despite the detector
	# still being covered.
	rope.on_reached_peak.connect(pre_exit)

func do(_delta: float) -> void:
	core.global_position = rope.hang_point.global_position

func exit() -> void:
	super.exit()
	core.velocity = rope.direction * core.stats.rope_swing_speed
	rope = null

func pre_exit(do_release: bool = true) -> void:
	super.pre_exit(do_release)
	rope.on_reached_peak.disconnect(pre_exit)
