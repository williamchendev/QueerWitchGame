/// @description Unit Path Debug Draw Event
// Draws the unit debug ui to the screen

// Debug
if (!global.debug) {
	return;
}

// Draw 
if (ai_behaviour) {
	// Draw Path
	if (path_array != noone) {
		draw_set_color(c_red);
		
		for (var i = 0; i < array_height_2d(path_array); i++) {
			// Find Path Point
			var temp_path_x = path_array[i, 1];
			var temp_path_y = path_array[i, 2];
			var temp_path_ground_x = path_array[i, 1];
			var temp_path_ground_y = path_array[i, 2];
			if (path_array[i, 0].object_index == oPathNode or object_is_ancestor(path_array[i, 0].object_index, oPathNode)) {
				temp_path_x = path_array[i, 0].x;
				temp_path_y = path_array[i, 0].y;
			}
			else if (path_array[i, 0].object_index == oPathEdge or object_is_ancestor(path_array[i, 0].object_index, oPathEdge)) {
				if (i == 0) {
					temp_path_x = path_debug_start_x;
					temp_path_y = path_debug_start_y;
				}
				else {
					temp_path_x = path_debug_end_x;
					temp_path_y = path_debug_end_y;
				}
			}
			
			if (i < array_height_2d(path_array) - 1) {
				// Find Next Path Point
				var temp_path_next_x = path_array[i + 1, 1];
				var temp_path_next_y = path_array[i + 1, 2];
				if (path_array[i + 1, 0].object_index == oPathNode or object_is_ancestor(path_array[i + 1, 0].object_index, oPathNode)) {
					temp_path_next_x = path_array[i + 1, 0].x;
					temp_path_next_y = path_array[i + 1, 0].y;
				}
				else if (path_array[i + 1, 0].object_index == oPathEdge or object_is_ancestor(path_array[i + 1, 0].object_index, oPathEdge)) {
					temp_path_next_x = path_debug_end_x;
					temp_path_next_y = path_debug_end_y;
				}
				
				// Draw Path Line
				draw_line(temp_path_x, temp_path_y, temp_path_next_x, temp_path_next_y);
			}
			
			// Draw Path Point
			draw_circle(temp_path_ground_x, temp_path_ground_y, 3, false);
			draw_line(temp_path_x, temp_path_y, temp_path_ground_x, temp_path_ground_y);
			draw_circle(temp_path_x, temp_path_y, 5, false);
		}
		
		// Draw Current Target Point
		if (path_array_index < array_height_2d(path_array)) {
			var temp_path_target_x = path_array[path_array_index, 1];
			var temp_path_target_y = path_array[path_array_index, 2];
			if (path_array[path_array_index, 0].object_index == oPathNode or object_is_ancestor(path_array[path_array_index, 0].object_index, oPathNode)) {
				temp_path_target_x = path_array[path_array_index, 0].x;
				temp_path_target_y = path_array[path_array_index, 0].y;
			}
			else if (path_array[path_array_index, 0].object_index == oPathEdge or object_is_ancestor(path_array[path_array_index, 0].object_index, oPathEdge)) {
				if (path_array_index == 0) {
					temp_path_target_x = path_debug_start_x;
					temp_path_target_y = path_debug_start_y;
				}
				else {
					temp_path_target_x = path_debug_end_x;
					temp_path_target_y = path_debug_end_y;
				}
			}
		
			draw_set_color(c_blue);
			draw_circle(temp_path_target_x, temp_path_target_y, 5, false);
		}
	}
	
	// Draw Path Edge
	/*
	if (path_edge != noone) {
		draw_set_color(c_blue);
		draw_line(path_edge.nodes[0].x, path_edge.nodes[0].y, path_edge.nodes[1].x, path_edge.nodes[1].y);
	}
	*/
	
	// Draw Movement Indexing Radius
	draw_set_color(c_purple);
	draw_circle(x, y, path_increment_index_radius / 2, false);
	draw_circle(x, y, path_increment_index_radius, true);
	
	// Reset Draw Color
	draw_set_color(c_white);
}