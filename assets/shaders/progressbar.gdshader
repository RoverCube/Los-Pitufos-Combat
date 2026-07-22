shader_type canvas_item;

uniform float progress  : hint_range(0.0, 1.0) = 1.0;
uniform sampler2D mask  : source_color;
uniform sampler2D fill  : source_color;

void fragment() {
	float mask_texture = texture(mask, UV).r;
	vec3 fill_texture = texture(fill, UV).rgb;
	
	mask_texture = mask_texture;
	
	float varied_progress = progress * 1.0;
	
	COLOR.rgb = mix(COLOR.rgb, fill_texture, float(mask_texture < progress ? 1.0 : 0.0));
}