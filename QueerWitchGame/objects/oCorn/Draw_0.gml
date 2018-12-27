/// @description Corn Draw Event
// Draws all the corn here

// Iterates through all points on the corn stalk
for (var i = 0; i < points - 1; i++) {
	// Draw Corn Stalk
	draw_line_width_color(x_position[i], y_position[i], x_position[i + 1], y_position[i + 1], width, stalk_color_a_merge, stalk_color_b_merge);
	draw_line_width_color(x_position[i] + 1, y_position[i], x_position[i + 1] + 1, y_position[i + 1], width / 2, stalk_color_c_merge, stalk_color_c_merge);
	
	// Iterate through points of the corn's leaves
	for (var l = 0; l < leaf_points[i]; l++) {
		// Draw Corn leaves
		draw_line_color(x_position[i], y_position[i], leaf_x_position[i, l] + x_position[i], leaf_y_position[i, l] + y_position[i], leaf_color_merge[i, l], leaf_color_merge[i, l]);
	}
}

// Iterate through points of corn's tassle leaves
for (var l = 0; l < leaf_points[points - 1]; l++) {
	// Draw Corn Tassles
	draw_line_color(x_position[points - 1], y_position[points - 1], leaf_x_position[points - 1, l] + x_position[points - 1], leaf_y_position[points - 1, l] + y_position[points - 1], stalk_color_a_merge, stalk_color_a_merge);
}