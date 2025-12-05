shader_type canvas_item;

uniform bool enabled = true;

uniform float speed : hint_range(-10.0, 10.0) = 1.0;
uniform float scale : hint_range(0.1, 20.0) = 3.0;
uniform float intensity : hint_range(0.0, 3.0) = 1.0;
uniform vec2 direction = vec2(1.0, 0.0);
uniform float contrast : hint_range(0.0, 2.0) = 1.0;
uniform float alpha_threshold : hint_range(0.0, 0.2) = 0.01;

void fragment() {
	if (!enabled) {
	    COLOR = texture(TEXTURE, UV) * COLOR;
	} else {
	    vec4 src = texture(TEXTURE, UV);
	    float a = src.a * COLOR.a;

	    if (a <= alpha_threshold) {
	        COLOR = vec4(0.0, 0.0, 0.0, 0.0);
	    } else {
	        float pos = dot(UV, normalize(direction)) * scale;
	        float phase = pos + TIME * speed;

	        float r = 0.5 + 0.5 * sin(phase * 6.2831853 + 0.0);
	        float g = 0.5 + 0.5 * sin(phase * 6.2831853 + 2.0943951);
	        float b = 0.5 + 0.5 * sin(phase * 6.2831853 + 4.1887902);

	        vec3 col = pow(vec3(r, g, b), vec3(1.0 / contrast)) * intensity;

	        COLOR = vec4(col * src.rgb, a);
		}
    }
}
