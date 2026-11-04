shader_type canvas_item;

uniform sampler2D mask : source_color;
uniform float     value: hint_range(0.0, 1.0) = 0.5;

void fragment() {
	
	if (texture(mask,UV).r > value) {
		COLOR.a = 0.0;
	}
	//(COLOR = texture(mask,UV);
}