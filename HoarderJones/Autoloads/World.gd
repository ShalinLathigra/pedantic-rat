extends Node

const TILE_SIZE := 16

func find_tile_intersection(origin: Vector2) -> Vector2:
	var point = Vector2()
	point.x = snappedi(origin.x, World.TILE_SIZE)
	point.y = snappedi(origin.y, World.TILE_SIZE)
	return point

func find_nearest_half_tile(origin: Vector2, on_x: bool=true, on_y: bool=false) -> Vector2:
	if not on_x or on_y:
		return origin
	# This gets the nearest full intersection
	var nearest_tile_intersection := find_tile_intersection(origin)
	# half tiles can be at:
	var x_options = [0.5 * World.TILE_SIZE, -0.5 * World.TILE_SIZE] if on_x else [0,0]
	var y_options = [0.5 * World.TILE_SIZE, -0.5 * World.TILE_SIZE] if on_y else [0,0]

	var neighbors = []
	for x in x_options:
		for y in y_options:
			neighbors.push_back(Vector2(x, y))

	var nearest = neighbors[0]
	var nearest_dist = (nearest_tile_intersection + neighbors[0] * World.TILE_SIZE).distance_squared_to(origin)
	for i in range(1, neighbors.size()):
		var dist = (nearest_tile_intersection + neighbors[i]).distance_squared_to(origin)
		if dist < nearest_dist:
			nearest = neighbors[i]
			nearest_dist = dist
	return nearest_tile_intersection + nearest
