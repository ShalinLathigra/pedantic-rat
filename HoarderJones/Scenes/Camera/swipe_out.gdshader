shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 background_color: source_color;
uniform float left_edge: hint_range(0.0, 1.0, 0.01);

varying vec4 modulate;

void vertex() {
	modulate = COLOR;
}

void fragment() {
	vec4 tex = textureLod(screen_texture, SCREEN_UV, 0.0);
	float t = step(left_edge, UV.x);
	COLOR = tex * t + background_color * (1.0 - t);
}
