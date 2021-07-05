shader_type canvas_item;

uniform float blur : hint_range(0, 6) = 2.5;

void fragment () {
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV, blur);
}