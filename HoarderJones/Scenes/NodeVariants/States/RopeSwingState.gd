class_name RopeSwingState
extends State

var rope: RopeSwing


func enter() -> void:
	super.enter()
	assert(rope)
	rope.trigger_rope_swing(core.global_position)
	core.lock_components(true)
	core.velocity = Vector2.ZERO
	rope.on_reached_peak.connect(core.release)

func do(_delta: float) -> void:
	core.global_position = rope.hang_point.global_position

func exit() -> void:
	super.exit()
	core.velocity = rope.direction * core.stats.rope_swing_speed
	rope.on_reached_peak.disconnect(core.release)
