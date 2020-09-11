/// @description Unit Path Update Event
// Performs calculations necessary for the Pathfinding Unit's behaviour

// Ai Behaviour Check
if (!ai_behaviour) {
	// Unit Physics & Behaviour Event
	event_inherited();
	return;
}

// Sight Behaviour
if (sight) {
	// Sight Angle
	sight_angle = (sign(image_xscale) * -90) + 90;

	// Sight Calculation
	var temp_sight_origin_distance = point_distance(0, 0, sight_origin_x, sight_origin_y);
	var temp_sight_origin_direction = point_direction(0, 0, sight_origin_x, sight_origin_y);
	var temp_sight_x = x + lengthdir_x(temp_sight_origin_distance, temp_sight_origin_direction + draw_angle);
	var temp_sight_y = y + lengthdir_y(temp_sight_origin_distance, temp_sight_origin_direction + draw_angle) * draw_yscale;

	var temp_sight_angle = sight_angle - (sight_arc / 2);
	var temp_sight_point_1_x = lengthdir_x(sight_radius, temp_sight_angle);
	var temp_sight_point_1_y = lengthdir_y(sight_radius, temp_sight_angle);
	var temp_sight_point_2_x = lengthdir_x(sight_radius, temp_sight_angle + sight_arc);
	var temp_sight_point_2_y = lengthdir_y(sight_radius, temp_sight_angle + sight_arc);

	// Create Sight Unit List
	var temp_sight_unit_list = ds_list_create();
	collision_circle_list(temp_sight_x, temp_sight_y, sight_radius, oUnit, true, true, temp_sight_unit_list, false);

	// Iterate through Units within sight radius
	for (var l = ds_list_size(temp_sight_unit_list) - 1; l >= 0; l--) {
		// Find Unit
		var temp_sight_unit = ds_list_find_value(temp_sight_unit_list, l);
		
		// Find Unit Sight Hitbox
		var temp_unit_top_left_x = temp_sight_unit.hitbox_left_top_x_offset + temp_sight_unit.x;
		var temp_unit_top_left_y = temp_sight_unit.hitbox_left_top_y_offset + temp_sight_unit.y;
		var temp_unit_bot_right_x = temp_sight_unit.hitbox_right_bottom_x_offset + temp_sight_unit.x;
		var temp_unit_bot_right_y = temp_sight_unit.hitbox_right_bottom_y_offset + temp_sight_unit.y;
		
		// Check if Unit is in Sight Arc
		var temp_sight_unit_valid = false;
		if (rectangle_in_triangle(temp_unit_top_left_x, temp_unit_top_left_y, temp_unit_bot_right_x, temp_unit_bot_right_y, temp_sight_x, temp_sight_y, temp_sight_x + temp_sight_point_1_x, temp_sight_y + temp_sight_point_1_y, temp_sight_x + temp_sight_point_2_x, temp_sight_y + temp_sight_point_2_y)) {
			// Find Unit Height
			var temp_sight_unit_height = temp_unit_bot_right_y - temp_unit_top_left_y;
			
			// Check for Solids
			for (var k = 0; k <= temp_sight_unit_height; k += (temp_sight_unit_height / 2)) {
				if (!collision_line(temp_sight_x, temp_sight_y, temp_sight_unit.x, temp_sight_unit.y - k, oSolid, false, true)) {
					temp_sight_unit_valid = true;
					break;
				}
			}
		}
		
		// Remove Unit if not viable
		if (!temp_sight_unit_valid) {
			ds_list_delete(temp_sight_unit_list, l);
		}
	}
	
	// Iterate through valid visible Units
	sight_unit_num = 0;
	sight_unit_nearest = noone;
	var temp_sight_unit_dis = 0;
	for (var l = 0; l < ds_list_size(temp_sight_unit_list); l++) {
		// Find Unit
		var temp_sight_unit = ds_list_find_value(temp_sight_unit_list, l);
		
		// Check Unit Team ID
		if (temp_sight_unit.team_id != team_id) {
			sight_unit_num++;
			var temp_sight_new_unit_dis = point_distance(temp_sight_x, temp_sight_y, temp_sight_unit.x, temp_sight_unit.y);
			
			if (sight_unit_nearest != noone) {
				if (temp_sight_new_unit_dis < temp_sight_unit_dis) {
					sight_unit_nearest = temp_sight_unit;
					temp_sight_unit_dis = temp_sight_new_unit_dis;
				}
			}
			else {
				sight_unit_nearest = temp_sight_unit;
				temp_sight_unit_dis = temp_sight_new_unit_dis;
			}
		}
	}
	
	// Set Sight Unit last seen variables
	if (sight_unit_nearest != noone) {
		sight_unit_seen = true;
		sight_unit_seen_x = sight_unit_nearest.x;
		sight_unit_seen_y = sight_unit_nearest.y;
	}

	// Garbage Collection
	ds_list_destroy(temp_sight_unit_list);
}

// Ai Behaviour
if (ai_behaviour_mode != "debug") {
	// Behaviour Switch
	switch (ai_behaviour_mode) {
		case "sentry":
			// Sentry Behaviour
			pathing = false;
			// Set Pursue Enemy
			if (sight_unit_num <= 0) {
				if (sight_unit_seen) {
					// Create New Path to Unit last seen
					sight_unit_seen = false;
					
					path_create = true;
					path_end_x = sight_unit_seen_x;
					path_end_y = sight_unit_seen_y;
					ai_behaviour_mode = "hunt";
				}
			}
			break;
		case "patrol":
			// Patrol Behaviour
			
			// Set Targeting Behaviour
			if (sight_unit_num > 0) {
				ai_behaviour_mode = "sentry";
			}
			break;
		case "hunt":
			if (!pathing) {
				if (sight_unit_num <= 0) {
					ai_behaviour_mode = "sentry";
				}
			}
			break;
		case "squad":
			break;
		default:
			break;
	}
}

// Path Array Creation
if (path_create) {
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
	
	// Reset
	path_create = false;
}

// Set Pathfinding Active
var temp_pathfind_active = false;
if (pathing) {
	if (path_array_index < array_height_2d(path_array)) {
		temp_pathfind_active = true;
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