extends Node2D

@onready var background_player := $BackgroundPlayer2D as AudioStreamPlayer
@onready var camera := %MainCamera as Camera2D
@onready var room_layer := %RoomLayer as CanvasLayer
@onready var core := %Hero as Character

func _ready():
	World.map = $RoomLayer/TileMap as TileMap
	background_player.play(0.0)

	assert(core)
	for child in room_layer.get_children():
		if child is WorldArea2D:
			child.core = core
			child.on_entered.connect(camera._set_anchor.bind(child))
