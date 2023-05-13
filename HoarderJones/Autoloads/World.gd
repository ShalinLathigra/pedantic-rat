extends Node

const TILE_SIZE := 16

var map: TileMap

func find_tile_intersection_world(origin: Vector2) -> Vector2:
	var point = Vector2()
	point.x = snappedi(origin.x, World.TILE_SIZE)
	point.y = snappedi(origin.y, World.TILE_SIZE)
	return point

func find_nearest_ladder_center(origin: Vector2) -> Vector2:
	if not map: return origin
	var start_tile = map.local_to_map(origin)
	var tiles_to_check = [Vector2i.ZERO, Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.LEFT + Vector2i.UP, Vector2i.RIGHT + Vector2i.UP]
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
	var tiles_to_check = [Vector2i.ZERO, Vector2i.UP]
	var target_cell: Vector2
	for tile in tiles_to_check:
		var cell = map.get_cell_tile_data(0, start_tile + tile)
		if not cell or not cell.get_custom_data("is_ladder"):
			target_cell = start_tile + tile
	if target_cell == Vector2.ZERO:
		return origin
	return map.map_to_local(target_cell)
