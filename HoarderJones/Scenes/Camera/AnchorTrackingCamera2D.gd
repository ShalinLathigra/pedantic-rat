extends Camera2D

@export var core: Character

@onready var blackout_shader := $ScreenSpaceBlockOut.material as ShaderMaterial
@onready var screen_size := Vector2( ProjectSettings.get_setting("display/window/size/viewport_width"), \
								ProjectSettings.get_setting("display/window/size/viewport_height"))

var anchor_points : Array[WorldArea2D]
var anchor: WorldArea2D

var anchor_position: Vector2
var anchor_size: Vector2

var tw: Tween

const duration: float = 0.5

# when the areas are entered, emit the "transition" event.

func _ready() -> void:
	$ScreenSpaceBlockOut.visible = true
	assert(core)
	for child in $AnchorPoints.get_children():
		if child is WorldArea2D:
			child.core = core
			anchor_points.push_back(child as WorldArea2D)
			child.on_entered.connect(_set_anchor.bind(child))

func _process(delta: float) -> void:
	global_position = lerp(global_position, core.global_position, 0.2)
	blackout_shader.set_shader_parameter("rect_pos", anchor_position)
	blackout_shader.set_shader_parameter("rect_size", anchor_size)

func _set_anchor(new_anchor: WorldArea2D) -> void:
	anchor = new_anchor
	if tw:
		tw.stop()
	tw = create_tween().set_parallel(true).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
	tw.tween_property(self, "anchor_position", new_anchor.position, duration)
	tw.tween_property(self, "anchor_size", new_anchor.size, duration)
