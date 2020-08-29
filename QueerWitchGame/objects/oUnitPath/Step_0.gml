/// @description Unit Path Update Event
// Performs calculations necessary for the Pathfinding Unit's behaviour

// Path Array Creation
if (mouse_check_button_pressed(mb_left)) {
	// Calculate Jump
	var temp_x = 0;
	var temp_y = 0;
	
	var temp_sim_velocity = 0;
	var temp_sim_jump_velocity = hold_jump_spd;
	var temp_sim_grav_velocity = 0;
	var temp_sim_djump = false;
	
	temp_sim_velocity -= jump_spd;
	while (temp_sim_velocity < 0) {
		temp_sim_velocity -= temp_sim_jump_velocity;
		temp_sim_jump_velocity *= jump_decay;
		
		temp_sim_grav_velocity += grav_spd;
		temp_sim_grav_velocity *= grav_multiplier;
		temp_sim_grav_velocity = min(temp_sim_grav_velocity, max_grav_spd);
		temp_sim_velocity += temp_sim_grav_velocity;
		
		temp_x += spd;
		temp_y += temp_sim_velocity;
		
		if (!temp_sim_djump) {
			if (temp_sim_velocity >= -double_jump_spd) {
				temp_sim_velocity = 0;
				temp_sim_velocity -= double_jump_spd;
				temp_sim_jump_velocity = hold_jump_spd;
				temp_sim_djump = true;
			}
		}
	}
	path_jump_range_width = temp_x;
	path_jump_range_height = temp_y;
	
	// Create Path
	path_start_x = x;
	path_start_y = y;
	path_end_x = mouse_x;
	path_end_y = mouse_y;
	path_array = pathfind_get_path(path_start_x, path_start_y, path_end_x, path_end_y);
	path_array_index = 1;
	
	path_jump_up = false;
	path_jump_down = false;
	
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
		
			// Check if First Path Target is a Jump Edge
			var temp_start_path_edge_jump = false;
			if (path_array[0, 0].object_index == oPathEdge or object_is_ancestor(path_array[0, 0].object_index, oPathEdge)) {
				if (path_array[0, 0].jump) {
					temp_start_path_edge_jump = true;
				}
			}
			
			// Find Path Start Ground Tethers
			var temp_start_path_ground_y = raycast_ground_ignore_edge(path_debug_start_x, path_debug_start_y, 150, path_array[0, 0]);
			if (temp_start_path_ground_y == noone or temp_start_path_edge_jump) {
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
			
			// Check if Final Path Target is a Jump Edge
			var temp_end_path_edge_jump = false;
			if (path_array[array_height_2d(path_array) - 1, 0].object_index == oPathEdge or object_is_ancestor(path_array[array_height_2d(path_array) - 1, 0].object_index, oPathEdge)) {
				if (path_array[array_height_2d(path_array) - 1, 0].jump) {
					temp_end_path_edge_jump = true;
				}
			}
			
			// Find Path End Ground Tethers
			var temp_end_path_ground_y = raycast_ground_ignore_edge(path_debug_end_x, path_debug_end_y, 150, path_array[array_height_2d(path_array) - 1, 0]);
			if (temp_end_path_ground_y == noone or temp_end_path_edge_jump) {
				var temp_end_node_closest = path_array[array_height_2d(path_array) - 1, 0].nodes[0];
				if (point_distance(path_debug_end_x, path_debug_end_y, path_array[array_height_2d(path_array) - 1, 0].nodes[1].x, path_array[array_height_2d(path_array) - 1, 0].nodes[1].y) < point_distance(path_debug_end_x, path_debug_end_y, path_array[array_height_2d(path_array) - 1, 0].nodes[0].x, path_array[array_height_2d(path_array) - 1, 0].nodes[0].y)) {
					temp_end_node_closest = path_array[array_height_2d(path_array) - 1, 0].nodes[1];
				}
				path_debug_end_x = temp_end_node_closest.x;
				path_debug_end_y = temp_end_node_closest.y;
				var temp_last_index = array_height_2d(path_array) - 1;
				if (temp_end_path_ground_y) {
					path_array[temp_last_index + 1, 0] = path_array[temp_last_index, 0];
					path_array[temp_last_index + 1, 1] = temp_end_node_closest.x_position;
					path_array[temp_last_index + 1, 2] = temp_end_node_closest.y_position;
				}
				path_array[temp_last_index, 0] = temp_end_node_closest;
				path_array[temp_last_index, 1] = temp_end_node_closest.x_position;
				path_array[temp_last_index, 2] = temp_end_node_closest.y_position;
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
		
		// Set Path Behaviour Variables
		path_jump_up = false;
		path_jump_down = false;
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
		
		key_up_press = false;
		key_down_press = false;
		
		// Vertical Movement
		if (path_edge != noone) {
			if (path_edge.jump) {
				if (path_array_index < array_height_2d(path_array) - 1) {
					// Jump Behaviour
					if (path_jump_up) {
						// Jump Up
						key_up = true;
						
						// Double Jump Logic
						if (path_double_jump) {
							if (y_velocity >= 0) {
								key_up_press = true;
							}
						}
						if (y_velocity < -jump_spd) {
							path_double_jump = true;
						}
					}
					else if (path_jump_down) {
						// Jump Down
						if (raycast_ground(x, y - 1, 3) < path_array[path_array_index, 2]) {
							key_down_press = true;
						}
					}
					else {
						// Compare Node Heights
						if (path_array[path_array_index, 2] < path_array[path_array_index - 1, 2]) {
							// Jump Up
							var temp_jump_height = path_array[path_array_index - 1, 2] - path_array[path_array_index, 2];
							if (temp_jump_height < -path_jump_range_height) {
								if (abs(path_array[path_array_index, 1] - x) < path_jump_range_width) {
									path_jump_up = true;
									path_double_jump = false;
									path_jump_down = false;
								}
							}
						}
						else if (path_array[path_array_index, 2] > path_array[path_array_index - 1, 2]) {
							// Jump Down
							path_jump_down = true;
							path_jump_up = false;
						}
					}
				}
			}
		}
		
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