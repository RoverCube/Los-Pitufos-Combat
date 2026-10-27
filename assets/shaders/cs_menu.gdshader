shader_type canvas_item;

uniform sampler2D sections : source_color;

uniform sampler2D image_1  : source_color;
uniform sampler2D image_2  : source_color;
uniform sampler2D image_3  : source_color;
uniform sampler2D image_4  : source_color;
uniform sampler2D image_5  : source_color;
uniform sampler2D image_6  : source_color;
uniform sampler2D image_7  : source_color;
uniform sampler2D image_8  : source_color;

vec3 section(sampler2D a, vec3 b, vec3 this_section, vec4 color) {
	return mix(b,texture(a,color.rg).rgb, this_section);}

void fragment() {
	vec3 sec = texture(sections,UV).rgb;
	vec3 section_1 = vec3((sec == vec3(0.0,0.0,0.0)) ? 1.0: 0.0);
	vec3 section_2 = vec3((sec == vec3(1.0,1.0,1.0)) ? 1.0: 0.0);
	vec3 section_3 = vec3((sec == vec3(1.0,0.0,0.0)) ? 1.0: 0.0);
	vec3 section_4 = vec3((sec == vec3(0.0,1.0,0.0)) ? 1.0: 0.0);
	vec3 section_5 = vec3((sec == vec3(0.0,0.0,1.0)) ? 1.0: 0.0);
	vec3 section_6 = vec3((sec == vec3(1.0,1.0,0.0)) ? 1.0: 0.0);
	vec3 section_7 = vec3((sec == vec3(1.0,0.0,1.0)) ? 1.0: 0.0);
	vec3 section_8 = vec3((sec == vec3(0.0,1.0,1.0)) ? 1.0: 0.0);
	
	//COLOR = vec4(UV.r,UV.g, 0.0, 1.0);
	COLOR.rgb = section(image_1,section(image_2,section(image_3,section(image_4,section(image_5,section(image_6,section(image_7,section(image_8,vec3(0.0),section_8,COLOR),section_7,COLOR),section_6,COLOR),section_5,COLOR),section_4,COLOR),section_3,COLOR),section_2,COLOR),section_1,COLOR);
}
