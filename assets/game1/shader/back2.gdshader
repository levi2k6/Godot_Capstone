shader_type canvas_item;
uniform float speed = 0.03;
void vertex() {
	UV.x += TIME * 0.03;
	UV.y += TIME * 0.03;
}

