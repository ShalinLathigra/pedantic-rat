class_name LadderDetector
extends Node2D

@onready var ladder_checker := $LadderChecker as Area2D
@onready var ascent_checker := $AscentChecker as Area2D
@onready var descent_checker := $DescentChecker as Area2D
@onready var ground_ray := $GroundRaycast as RayCast2D

var core_covered : bool:
	get: return ladder_checker.has_overlapping_bodies() or ladder_checker.has_overlapping_areas()

var ascent_covered : bool:
	get: return ascent_checker.has_overlapping_bodies() or ascent_checker.has_overlapping_areas()

var descent_covered : bool:
	get: return descent_checker.has_overlapping_bodies() or descent_checker.has_overlapping_areas()

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

func find_ladder_center(origin: Vector2) -> Vector2:
	# if dealing
	if ladder_checker.has_overlapping_areas():
		return Vector2(ladder_checker.get_overlapping_areas()[0].global_position.x, origin.y)
	return World.find_nearest_ladder_center(origin)
