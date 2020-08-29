/// @description Unit Path Update Event
// Performs calculations necessary for the Pathfinding Unit's behaviour

// Path Array Creation
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
			// Set Pathing Active
			pathing = true;
			
			// Set Debug Variables
			path_debug_start_x = path_array[0, 1];
			path_debug_start_y = path_array[0, 2];
			
			path_debug_end_x = path_array[array_height_2d(path_array) - 1, 1];
			path_debug_end_y = path_array[array_height_2d(path_array) - 1, 2];
		
			// Find Path Start Ground Tethers
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
			
			// Find Path End Ground Tethers
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
			
			// Find Path Edge
			path_edge = noone;
			var temp_start_node_a_viable = path_array[0, 0].object_index == oPathNode or object_is_ancestor(path_array[0, 0].object_index, oPathNode);
			var temp_start_node_b_viable = path_array[1, 0].object_index == oPathNode or object_is_ancestor(path_array[1, 0].object_index, oPathNode)
			if (temp_start_node_a_viable and temp_start_node_b_viable) {
				path_edge = pathfind_get_node_edge(path_array[0, 0], path_array[1, 0]);
			}
			else if (path_array[0, 0].object_index == oPathEdge or object_is_ancestor(path_array[0, 0].object_index, oPathEdge)) {
				path_edge = path_array[0, 0];
			}
		}
	}
}

// Set Pathfinding Active
var temp_pathfind_active = false;
if (ai_behaviour) {
	if (pathing) {
		if (path_array_index < array_height_2d(path_array)) {
			temp_pathfind_active = true;
		}
	}
}

// Pathfinding Behaviour
while (temp_pathfind_active) {
	// Check to Increment Path Array Index
	if (point_distance(x, y, path_array[path_array_index, 1], path_array[path_array_index, 2]) < path_increment_index_radius) {
		// Increment Index
		path_array_index++;
		
		if (path_array_index >= array_height_2d(path_array)) {
			// End Pathing
			pathing = false;
			path_edge = noone;
			break;
		}
		else {
			// Find Path Edge
			path_edge = noone;
			if (path_array_index <= array_height_2d(path_array) - 1) {
				if (path_array[path_array_index, 0].object_index == oPathNode or object_is_ancestor(path_array[path_array_index, 0].object_index, oPathNode)) {
					if (path_array[path_array_index - 1, 0].object_index == oPathNode or object_is_ancestor(path_array[path_array_index - 1, 0].object_index, oPathNode)) {
						path_edge = pathfind_get_node_edge(path_array[path_array_index, 0], path_array[path_array_index - 1, 0]);
					}
				}
				else if (path_array[path_array_index, 0].object_index == oPathEdge or object_is_ancestor(path_array[path_array_index, 0].object_index, oPathEdge)) {
					path_edge = path_array[path_array_index, 0];
				}
			}
		}
	}
		
	// Determine Movement Behaviour
	if (path_array_index < array_height_2d(path_array)) {
		// Reset Movement Behaviour Variables
		key_left = false;
		key_right = false;
		key_up = false;
		key_down = false;
		
		// Horizontal Movement
		if (x > path_array[path_array_index, 1] + (path_x_delta_tolerance / 2)) {
			key_left = true;
		}
		else if (x < path_array[path_array_index, 1] - (path_x_delta_tolerance / 2)) {
			key_right = true;
		}
	}
	
	// Exit Pathfinding Behaviour
	break;
}

// Unit Physics & Behaviour Event
event_inherited();