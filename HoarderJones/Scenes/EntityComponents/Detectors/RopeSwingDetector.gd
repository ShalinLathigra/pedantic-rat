class_name RopeSwingDetector
extends Node2D

@onready var rope_checker := $RopeChecker as Area2D

var is_covered : bool:
	get: return rope != null
var rope : RopeSwing

func on_rope_checker_area_entered(area: Area2D) -> void:
	if not area is RopeSwing: return
	rope = area as RopeSwing


func on_rope_checker_area_exited(area: Area2D) -> void:
	if area == rope:
		rope = null
