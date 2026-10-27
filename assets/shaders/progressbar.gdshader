shader_type canvas_item;

uniform float value  : hint_range(0.0, 1.0) = 0.5;
uniform sampler2D mask  : source_color;

void fragment() {
	float mask_texture = texture(mask, UV).r;
	
	COLOR.rgb = mix(vec3(0.0), COLOR.rgb, float(mask_texture < value ? 1.0 : 0.0));
	RCOLO
}