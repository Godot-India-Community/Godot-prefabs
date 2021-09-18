shader_type canvas_item;

uniform float level_1 : hint_range(0.0, 1.0) = 0.5;
uniform float level_1_smoothing : hint_range(0.0, 1.0) = 0.03; // Lengthens the color transition
uniform float level_2 : hint_range(0.0, 1.0) = 0.0;   // If left at 0, only level 1 is used.
uniform float level_2_smoothing : hint_range(0.0, 1.0) = 0.03;
uniform float min_light : hint_range(0.0, 1.0) = 0.0;
uniform float mid_light : hint_range(0.0, 1.0) = 0.0; // If left at 0 it defaults to calculating between min and max.
uniform float max_light : hint_range(0.0, 1.0) = 1.0;

void light() {
	float nl = -dot(normalize(vec3(LIGHT_VEC,-LIGHT_HEIGHT)), NORMAL);
	float diff = max(nl, 0.0)*LIGHT_COLOR.a;
	float mid_range_light = mid_light;
	if (mid_light == 0.0) { mid_range_light = (max_light * 0.66) + (min_light * 0.33); }
	if (level_1 != 0.0 && level_2 == 0.0) {
		diff = smoothstep(level_1, (level_1 + level_1_smoothing), diff) + min_light;
		if (diff == 0.0) { diff = min_light; } else if (diff >= 1.0 || diff > max_light) { diff = max_light; }
	} else if (level_1 != 0.0 && level_2 != 0.0) {
		if (diff <= level_1) {
			diff = smoothstep((level_1 - level_1_smoothing), level_1, diff) + min_light;
			if (diff == 0.0) { diff = min_light; }
			if (diff > mid_range_light) { diff = mid_range_light; }
		} else if (diff > level_2) {
			diff = smoothstep(level_2, (level_2 + level_2_smoothing), diff) + (mid_range_light);
			if (diff < mid_range_light) { diff = mid_range_light; }
			if (diff >= 1.0 || diff >= max_light) { diff = max_light; }
		} else {
			diff = mid_range_light;
		}
	}
	LIGHT_VEC = -NORMAL.xy*length(LIGHT_VEC);
	LIGHT_COLOR = diff*LIGHT_COLOR;
	LIGHT = LIGHT;
}
