shader_type canvas_item;

uniform vec2 offset;
uniform vec4 first_color: source_color;
uniform vec4 second_color: source_color;

void fragment(){     
	vec4 base = COLOR;
	
	
	vec4 first = texture(TEXTURE , UV + TEXTURE_PIXEL_SIZE * offset);
	vec4 second = texture(TEXTURE , UV + TEXTURE_PIXEL_SIZE * offset * 2.0);
	
	first *= first_color;
	second *= second_color;
	vec4 bf = mix(first, base, base.a);
	
	COLOR = mix(second, bf, bf.a);
}