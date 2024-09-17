shader_type canvas_item;


uniform float speed = 0.3;
uniform sampler2D noise_texture : hint_default_black, repeat_enable;

void fragment() {
	//vec2 uv = vec2(sqrt(pow(UV.x,2)+(pow(UV.y,2)))+(TIME*speed), sqrt(pow(UV.x,2)+(pow(UV.y,2)))+(TIME*speed));
	vec4 final_color;
	if (COLOR.r < 0.9 && COLOR.a > 0.1){
		vec2 uv = vec2(UV.x, UV.y - (TIME*speed));
		final_color = texture(noise_texture, uv);
		if (final_color.g > 0.65)
			final_color = vec4(69.0/256.0, 40.0/256.0, 108.0/256.0,1.0);
		else
			final_color = vec4(0,0,0,1);
	}
	//COLOR = final_color;
}
