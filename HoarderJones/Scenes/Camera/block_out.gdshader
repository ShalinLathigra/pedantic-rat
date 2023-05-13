shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 background_color: source_color;

// how big is the camera?
uniform vec2 camera_size;
// Define the visible area
uniform vec2 rect_pos;
uniform vec2 rect_size;


/*
needs to be aware of:
	- Camera position
	- Rectangle position
	- Screen width
	- rectangle width
*/

varying vec2 pos;

void vertex() {
	pos = (MODEL_MATRIX * vec4(VERTEX, 0.0, 1.0)).xy;
}

void fragment() {
	vec4 tex = textureLod(screen_texture, SCREEN_UV, 0.0);
	float t = step(rect_pos.x - rect_size.x / 2.0, pos.x);
	t *= step(pos.x, rect_pos.x + rect_size.x / 2.0);
	t *= step(rect_pos.y - rect_size.y / 2.0, pos.y);
	t *= step(pos.y, rect_pos.y + rect_size.y / 2.0);
	COLOR = t * tex + background_color * (1.0 - t);
}
