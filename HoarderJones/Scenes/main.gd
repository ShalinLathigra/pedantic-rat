extends Node2D

@onready var background_player := $BackgroundPlayer2D as AudioStreamPlayer

func _ready():
	World.map = $TileMap as TileMap
	background_player.play(0.0)
