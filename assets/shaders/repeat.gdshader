shader_type canvas_item;

uniform vec2 offset;
uniform bool full_white = false;
uniform vec4 alt_base_color: source_color;
uniform vec4 first_color: source_color;
uniform vec4 second_color: source_color;

void fragment(){     
	vec4 base = COLOR;
	
	if ( full_white ) {
		base = mix(vec4(0.0),alt_base_color, base.a);
	}
	vec4 first = vec4(texture(TEXTURE , UV + TEXTURE_PIXEL_SIZE * offset).a);
	vec4 second = vec4(texture(TEXTURE , UV + TEXTURE_PIXEL_SIZE * offset * 2.0).a);
	
	first *= first_color;
	second *= second_color;
	vec4 bf = mix(first, base, base.a);
	
	COLOR = mix(second, bf, bf.a);
}