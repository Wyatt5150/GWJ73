shader_type canvas_item;

void fragment() {
	vec4 final_color = COLOR;
	final_color = final_color - vec4(0.2, 0.2, 0.2, 0.5);
	
	
	COLOR = final_color;
}