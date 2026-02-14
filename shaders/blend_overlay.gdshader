shader_type canvas_item;

uniform vec3 blend : source_color;
uniform float mix_amount = 1.0;

void fragment() {
	vec4 base = texture(TEXTURE, UV);
	vec3 base_c = vec3(base.r, base.g, base.b);
	vec3 limit = step(0.5, base_c);
	COLOR.rgb = mix(2.0 * base_c * blend, 1.0 - 2.0 * (1.0 - base_c) * (1.0 - blend), limit);
}