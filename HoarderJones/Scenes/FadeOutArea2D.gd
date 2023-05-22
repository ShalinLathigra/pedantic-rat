extends Area2D

var tw: Tween
func fade(_body: Node2D, in_or_out: bool) -> void:
	if tw:
		tw.stop()
	tw = create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tw.tween_interval(0.25)
	tw.tween_property(self, "modulate:a", 1.0 if in_or_out else 0.0, 0.5)
