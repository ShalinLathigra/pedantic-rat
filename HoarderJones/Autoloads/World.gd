extends Node

const TILE_SIZE := 16

var map: TileMap

func find_tile_intersection_world(origin: Vector2) -> Vector2:
	var point = Vector2()
	point.x = snappedi(origin.x, World.TILE_SIZE)
	point.y = snappedi(origin.y, World.TILE_SIZE)
	return point

func find_nearest_ladder_center(origin: Vector2, x_only: bool=true) -> Vector2:
	if not map: return origin
	var start_tile = map.local_to_map(origin)
	var tiles_to_check = [Vector2i.ZERO, Vector2i.LEFT, Vector2i.RIGHT]
	if not x_only: tiles_to_check.append_array([Vector2i.UP, Vector2i.DOWN])
	var target_cell: Vector2
	for tile in tiles_to_check:
		var cell = map.get_cell_tile_data(0, start_tile + tile)
		if not cell: continue
		if cell.get_custom_data("is_ladder"):
			target_cell = start_tile + tile
			break
	if target_cell == Vector2.ZERO:
		return origin
	return map.map_to_local(target_cell)

func find_highest_ladder_center(origin: Vector2) -> Vector2:
	if not map: return origin
	var start_tile = map.local_to_map(origin)
	var tiles_to_check = [Vector2i.DOWN, Vector2i.ZERO, Vector2i.UP]
	var target_cell: Vector2
	for tile in tiles_to_check:
		var cell = map.get_cell_tile_data(0, start_tile + tile)
		if not cell:
			target_cell = start_tile + tile
			break
		if cell.get_custom_data("is_ladder"): continue
	if target_cell == Vector2.ZERO:
		return origin
	prints(origin, start_tile, target_cell, map.map_to_local(target_cell))
	return map.map_to_local(target_cell)

func find_nearest_half_tile(origin: Vector2, on_x: bool=true, on_y: bool=false) -> Vector2:
	if not on_x or on_y:
		return origin

	find_nearest_ladder_center(origin, on_x)
	# This gets the nearest full intersection
	var nearest_tile_intersection := find_tile_intersection_world(origin)
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

# alrighty, need to provide the world with a map reference
