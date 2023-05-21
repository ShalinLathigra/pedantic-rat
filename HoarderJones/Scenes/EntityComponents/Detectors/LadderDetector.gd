class_name LadderDetector
extends Node2D

@onready var ladder_checker := $LadderChecker as Area2D
@onready var ascent_checker := $AscentChecker as Area2D
@onready var descent_checker := $DescentChecker as Area2D
@onready var ground_ray := $GroundRaycast as RayCast2D

var core_covered : bool:
	get: return ladder_checker.has_overlapping_bodies()

var ascent_covered : bool:
	get: return ascent_checker.has_overlapping_bodies()

var descent_covered : bool:
	get: return descent_checker.has_overlapping_bodies()

var at_ladder_ground: bool:
	get: return ground_ray.is_colliding()

var at_bottom_of_ladder: bool:
	get: return core_covered and not ascent_covered

var at_top_of_ladder: bool:
	get: return core_covered and not descent_covered

func can_climb_in_direction(direction: Vector2) -> bool:
	if direction.y > 0:
		return ascent_covered and core_covered
	if direction.y < 0:
		return descent_covered and core_covered
	return false
