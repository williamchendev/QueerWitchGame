/// @description Unit Path Debug Draw Event
// Draws the unit debug ui to the screen

// Debug
if (!global.debug) {
	return;
}

// Draw Debug AI
if (ai_behaviour) {
	// Sight Behaviour
	if (sight) {
		// Draw Vision
		var temp_sight_origin_distance = point_distance(0, 0, sight_origin_x, sight_origin_y);
		var temp_sight_origin_direction = point_direction(0, 0, sight_origin_x, sight_origin_y);
		var temp_sight_x = x + lengthdir_x(temp_sight_origin_distance, temp_sight_origin_direction + draw_angle);
		var temp_sight_y = y + lengthdir_y(temp_sight_origin_distance, temp_sight_origin_direction + draw_angle) * draw_yscale;
	
		draw_set_alpha(0.1);
		draw_set_color(c_red);
		draw_primitive_begin(pr_trianglelist);

		for (var q = 0; q < sight_arc; q += sight_interpolate) {
			var temp_sight_angle = sight_angle - (sight_arc / 2) + q;
			var temp_sight_point_1_x = lengthdir_x(sight_radius, temp_sight_angle);
			var temp_sight_point_1_y = lengthdir_y(sight_radius, temp_sight_angle);
			var temp_sight_point_2_x = lengthdir_x(sight_radius, temp_sight_angle + sight_interpolate);
			var temp_sight_point_2_y = lengthdir_y(sight_radius, temp_sight_angle + sight_interpolate);
	
			draw_vertex(temp_sight_x, temp_sight_y);
			draw_vertex(temp_sight_x + temp_sight_point_1_x, temp_sight_y + temp_sight_point_1_y);
			draw_vertex(temp_sight_x + temp_sight_point_2_x, temp_sight_y + temp_sight_point_2_y);
		}

		draw_primitive_end();
		draw_set_alpha(1);

		// Draw Vision Point
		draw_set_color(c_red);
		draw_circle(temp_sight_x, temp_sight_y, 2, false);
	}

	// Draw Path
	if (!path_debug_draw) {
		return;
	}
	
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
	
	var temp_x = x;
	var temp_y = y;
	
	var temp_sim_velocity = 0;
	var temp_sim_jump_velocity = hold_jump_spd;
	var temp_sim_grav_velocity = 0;
	var temp_sim_djump = false;
	
	temp_sim_velocity -= jump_spd;
	draw_set_color(c_red);
	while (temp_sim_velocity < 0) {
		temp_sim_velocity -= temp_sim_jump_velocity;
		temp_sim_jump_velocity *= jump_decay;
		
		temp_sim_grav_velocity += grav_spd;
		temp_sim_grav_velocity *= grav_multiplier;
		temp_sim_grav_velocity = min(temp_sim_grav_velocity, max_grav_spd);
		temp_sim_velocity += temp_sim_grav_velocity;
		
		temp_x += spd * sign(image_xscale);
		temp_y += temp_sim_velocity;
		
		draw_point(temp_x, temp_y);
		
		if (!temp_sim_djump) {
			if (temp_sim_velocity >= -double_jump_spd) {
				temp_sim_velocity = 0;
				temp_sim_velocity -= double_jump_spd;
				temp_sim_jump_velocity = hold_jump_spd;
				temp_sim_djump = true;
			}
		}
	}
	draw_set_color(c_white);
	
	// Reset Draw Color
	draw_set_color(c_white);
}