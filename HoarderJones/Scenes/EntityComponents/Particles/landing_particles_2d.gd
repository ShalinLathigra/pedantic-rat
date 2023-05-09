extends GPUParticles2D

func _ready() -> void:
	emitting = true
	var tw = create_tween()
	tw.tween_interval(lifetime * speed_scale)
	tw.tween_callback(call_deferred.bind("queue_free"))
