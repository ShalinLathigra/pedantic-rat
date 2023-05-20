extends Camera2D

@export var core: Character
@export var room_layer: CanvasLayer

@onready var blackout_shader := $ScreenSpaceBlockOut.material as ShaderMaterial
@onready var viewport_size := Vector2( ProjectSettings.get_setting("display/window/size/viewport_width"), \
								ProjectSettings.get_setting("display/window/size/viewport_height"))

var anchor_position: Vector2
var anchor_size: Vector2
var screen_size: Vector2:
	get:
		return Vector2(viewport_size.x / zoom.x, viewport_size.y / zoom.y)

var tw: Tween

const duration: float = 0.5

# TODO: Use render passes to have this component occur afterwards
# Alternatively achieve this with two textures + screen effects.

func _ready() -> void:
	$ScreenSpaceBlockOut.visible = true
	anchor_position = global_position
	assert(core)
	for child in room_layer.get_children():
		if child is WorldArea2D:
			child.core = core
			child.on_entered.connect(_set_anchor.bind(child))

func _process(_delta: float) -> void:
	# Requirements
	# While tracking_player == true:
	#	move position towards this
	# 	position is
	var target_position: Vector2 = lerp(global_position, core.global_position, 0.2)
	var top_left: Vector2 = anchor_position - anchor_size * 0.5
	var bot_right: Vector2 = anchor_position + anchor_size * 0.5
	target_position.x = anchor_position.x if screen_size.x >= anchor_size.x \
									else clamp(target_position.x, \
									top_left.x + screen_size.x * 0.5, \
									bot_right.x - screen_size.x * 0.5)

	target_position.y = anchor_position.y if screen_size.y >= anchor_size.y \
									else clamp(target_position.y, \
									top_left.y + screen_size.y * 0.5, \
									bot_right.y - screen_size.y * 0.5)

	global_position = target_position
	blackout_shader.set_shader_parameter("rect_pos", anchor_position)
	blackout_shader.set_shader_parameter("rect_size", anchor_size)
	blackout_shader.set_shader_parameter("camera_size", screen_size)

func _set_anchor(new_anchor: WorldArea2D) -> void:
#	print("Camera Entering: ", new_anchor.name)
	if tw:
		tw.stop()
	tw = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "anchor_position", new_anchor.position, duration)
	tw.tween_property(self, "anchor_size", new_anchor.size, duration)
	tw.tween_property(self, "zoom", Vector2.ONE * new_anchor.zoom, duration)
