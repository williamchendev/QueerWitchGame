/// @description Unit Path Update Event
// Performs calculations necessary for the Pathfinding Unit's behaviour

if (mouse_check_button_pressed(mb_left)) {
	// Create Path
	path_start_x = x;
	path_start_y = y;
	path_end_x = mouse_x;
	path_end_y = mouse_y;
	path_array = pathfind_get_path(path_start_x, path_start_y, path_end_x, path_end_y);
	path_array_index = 1;
	
	// Clean Up Path
	if (path_array != noone) {
		if (array_height_2d(path_array) > 1) {
			// Set Debug Variables
			path_debug_start_x = path_array[0, 1];
			path_debug_start_y = path_array[0, 2];
			
			path_debug_end_x = path_array[array_height_2d(path_array) - 1, 1];
			path_debug_end_y = path_array[array_height_2d(path_array) - 1, 2];
		
			// Find Path Start and End Ground Tethers
			var temp_start_path_ground_y = raycast_ground_ignore_edge(path_debug_start_x, path_debug_start_y, 150, path_array[0, 0]);
			if (temp_start_path_ground_y == noone) {
				var temp_start_node_closest = path_array[0, 0].nodes[0];
				if (point_distance(path_debug_start_x, path_debug_start_y, path_array[0, 0].nodes[1].x, path_array[0, 0].nodes[1].y) < point_distance(path_debug_start_x, path_debug_start_y, path_array[0, 0].nodes[0].x, path_array[0, 0].nodes[0].y)) {
					temp_start_node_closest = path_array[0, 0].nodes[1];
				}
				path_debug_start_x = temp_start_node_closest.x;
				path_debug_start_y = temp_start_node_closest.y;
				path_array[0, 0] = temp_start_node_closest;
				path_array[0, 1] = temp_start_node_closest.x_position;
				path_array[0, 2] = temp_start_node_closest.y_position;
			}
			else {
				path_array[0, 2] = temp_start_path_ground_y;
			}
			
			var temp_end_path_ground_y = raycast_ground_ignore_edge(path_debug_end_x, path_debug_end_y, 150, path_array[array_height_2d(path_array) - 1, 0]);
			if (temp_end_path_ground_y == noone) {
				var temp_end_node_closest = path_array[array_height_2d(path_array) - 1, 0].nodes[0];
				if (point_distance(path_debug_end_x, path_debug_end_y, path_array[array_height_2d(path_array) - 1, 0].nodes[1].x, path_array[array_height_2d(path_array) - 1, 0].nodes[1].y) < point_distance(path_debug_end_x, path_debug_end_y, path_array[array_height_2d(path_array) - 1, 0].nodes[0].x, path_array[array_height_2d(path_array) - 1, 0].nodes[0].y)) {
					temp_end_node_closest = path_array[array_height_2d(path_array) - 1, 0].nodes[1];
				}
				path_debug_end_x = temp_end_node_closest.x;
				path_debug_end_y = temp_end_node_closest.y;
				path_array[array_height_2d(path_array) - 1, 0] = temp_end_node_closest;
				path_array[array_height_2d(path_array) - 1, 1] = temp_end_node_closest.x_position;
				path_array[array_height_2d(path_array) - 1, 2] = temp_end_node_closest.y_position;
			}
			else {
				path_array[array_height_2d(path_array) - 1, 2] = temp_end_path_ground_y;
			}
		}
	}
}

// Pathfinding
if (pathing) {
	if (path_array != noone) {
		if (path_array_index < array_height_2d(path_array)) {
			if (point_distance(x, y, path_array[path_array_index, 1], path_array[path_array_index, 2]) < path_movement_radius) {
				path_array_index++;
			}
		}
			
		// Determine Movement Behaviour
		if (path_array_index < array_height_2d(path_array)) {
			// Reset Movement Behaviour Variables
			key_left = false;
			key_right = false;
			key_up = false;
			key_down = false;
			
			if (x > path_array[path_array_index, 1]) {
				key_left = true;
			}
			else if (x < path_array[path_array_index, 1]) {
				key_right = true;
			}
		}
			
		/*
		key_left = keyboard_check(game_manager.left_check);
		key_right = keyboard_check(game_manager.right_check);
		key_up = keyboard_check(game_manager.up_check);
		key_down = keyboard_check(game_manager.down_check);
		*/
	}
}

// Unit Physics & Behaviour Event
event_inherited();