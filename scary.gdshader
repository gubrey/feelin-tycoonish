shader_type canvas_item;

uniform float amplitude = 2.;
uniform float move_amount = 0.1;
uniform float speed = 0.7;

void fragment() {
	vec2 distorted_uv = UV;
	
	distorted_uv.x += sin((TIME + distorted_uv.y * amplitude) * speed) * move_amount;
	distorted_uv = mod(distorted_uv, vec2(1.0, 1.0));
	
    COLOR = texture(TEXTURE, distorted_uv);
}
