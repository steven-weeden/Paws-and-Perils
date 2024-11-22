shader_type canvas_item;

uniform float distance_to_player;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float final_alpha;
	if(distance_to_player > 0.2)
		final_alpha = distance_to_player;
	else
		final_alpha = 0.0;      
	COLOR = vec4(1.0, 1.0, 1.0, final_alpha);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
