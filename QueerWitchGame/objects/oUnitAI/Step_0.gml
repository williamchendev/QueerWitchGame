/// @description Unit AI Update Event
// The AI calculations and behaviour of the Unit

// AI Behaviour
if (ai_behaviour and canmove) {
	// Reset Behaviour
	targeting = false;
	
	// Check AI Stimuli
	var temp_target_exists = false;
	if (sight_unit_nearest != noone) {
		if (instance_exists(sight_unit_nearest)) {
			temp_target_exists = true;
		}
		else {
			sight_unit_seen = false;
			sight_unit_nearest = noone;
		}
	}
	
	// AI Follow Behaviour
	if (ai_follow) {
		// Check if Follow Instance Exists
		var temp_follow_unit_exists = false;
		if (ai_follow_unit != noone) {
			if (instance_exists(ai_follow_unit)) {
				temp_follow_unit_exists = true;
			}
		}
		
		// Follow Calculations
		if (temp_follow_unit_exists) {
			// Check Distance
			if (point_distance(x, y, ai_follow_unit.x, ai_follow_unit.y) > ai_follow_start_radius) {
				// Set Following Active
				if (!ai_follow_active) {
					// Endure Combat
					if (!pathing) {
						if (temp_target_exists) {
							// Check Timer
							ai_follow_combat_timer -= global.deltatime;
							if (ai_follow_combat_timer <= 0) {
								ai_follow_active = true;
							}
						}
						else {
							ai_follow_active = true;
						}
					}
					else {
						ai_follow_active = true;
					}
				}
			}
		}
		else {
			// Garbage Collection
			if (!instance_exists(ai_follow_unit)) {
				pathing = false;
			}
			
			ai_follow = false;
			ai_follow_unit = noone;
			ai_follow_active = false;
		}
	}
	
	// AI Behaviour Switch
	var temp_aggro_behaviour_active = false;
	if (pathing and ai_command) {
		// Targeting Behaviour
		key_aim_press = false; // REMOVE REDUNDANCY
	}
	else if (ai_follow_active) {
		// Follow Behaviour
		if (!pathing and point_distance(x, y, ai_follow_unit.x, ai_follow_unit.y) <= ai_follow_stop_radius) {
			// Check Distance Reset
			ai_follow_active = false;
			ai_follow_combat_timer = ai_follow_combat_endure_time;
		}
		else {
			// Update Follow Pathing
			if (point_distance(path_end_x, path_end_y, ai_follow_unit.x, ai_follow_unit.y) > ai_follow_stop_radius) {
				// Check if Path Creation won't interrupt Jump
				var temp_valid_edge = true;
				if (path_edge != noone) {
					if (path_edge.jump) {
						temp_valid_edge = false;
					}
				}
				
				// Path Creation
				if (temp_valid_edge) {
					// Path Timer
					ai_pathing_timer++;
					if (ai_pathing_timer >= ai_pathing_delay) {
						// Find Unit Follow Edge
						var temp_ai_follow_unit_edge_data = pathfind_get_closest_point(ai_follow_unit.x, ai_follow_unit.y);
						var temp_ai_follow_unit_edge = temp_ai_follow_unit_edge_data[2];
						
						// Find Edge Points
						var temp_edge_p1_x = temp_ai_follow_unit_edge.nodes[0].x;
						var temp_edge_p1_y = temp_ai_follow_unit_edge.nodes[0].y;
						var temp_edge_p2_x = temp_ai_follow_unit_edge.nodes[1].x;
						var temp_edge_p2_y = temp_ai_follow_unit_edge.nodes[1].y;
						
						// Get Edge Data
						var temp_edge_p1_dis = point_distance(ai_follow_unit.x, ai_follow_unit.y, temp_edge_p1_x, temp_edge_p1_y);
						var temp_edge_p2_dis = point_distance(ai_follow_unit.x, ai_follow_unit.y, temp_edge_p2_x, temp_edge_p2_y);
						var temp_edge_p1_range = max(-temp_edge_p1_dis, -ai_follow_stop_radius / 2);
						var temp_edge_p2_range = min(temp_edge_p2_dis, ai_follow_stop_radius / 2);
						
						// Create Random Point on Edge
						var temp_follow_x = ai_follow_unit.x;
						var temp_follow_y = ai_follow_unit.y;
						var temp_random_edge_placement = irandom_range(temp_edge_p1_range, temp_edge_p2_range);
						if (temp_random_edge_placement < 0) {
							temp_follow_x = lerp(ai_follow_unit.x, temp_edge_p1_x, -temp_edge_p1_range / temp_edge_p1_dis);
							temp_follow_y = lerp(ai_follow_unit.y, temp_edge_p1_y, -temp_edge_p1_range / temp_edge_p1_dis);
						}
						else if (temp_random_edge_placement >= 0) {
							temp_follow_x = lerp(ai_follow_unit.x, temp_edge_p2_x, temp_edge_p2_range / temp_edge_p2_dis);
							temp_follow_y = lerp(ai_follow_unit.y, temp_edge_p2_y, temp_edge_p2_range / temp_edge_p2_dis);
						}
						
						// Create Path
						path_create = true;
						path_end_x = temp_follow_x;
						path_end_y = temp_follow_y;
						ai_pathing_timer = 0;
					}
				}
			}
		}
	}
	else if (ai_follow and squad_aim) {
		// Aim & Fire Where Ai Follow Unit Aims & Fires
		temp_aggro_behaviour_active = false;
		if (ai_follow_unit.squad_key_aim_press) {
			targeting = true;
			key_aim_press = true;
			key_fire_press = ai_follow_unit.squad_key_fire_press;
			target_x = ai_follow_unit.cursor_x;
			target_y = ai_follow_unit.cursor_y;
		}
	}
	else if (temp_target_exists) {
		// Target Visible Movement Behaviour
		if (pathing and ai_hunt) {
			// Redirect Direction to Target if Pathing
			if (sign(target_x - x) != image_xscale) {
				if (sign(target_x - x) != 0) {
					pathing = false;
				}
			}
		}
		
		// Attack Behaviour Active
		temp_aggro_behaviour_active = true;
	}
	else if (sight_unit_seen and ai_hunt) {
		// Last Seen AI Variables
		var temp_combat_unit_height = hitbox_right_bottom_y_offset - hitbox_left_top_y_offset;
		
		// Last Seen Movement Behaviour
		if (point_distance(x, y - (temp_combat_unit_height / 2), sight_unit_seen_x, sight_unit_seen_y) > ai_inspect_radius) {
			if (point_distance(path_end_x, path_end_y, sight_unit_seen_x, sight_unit_seen_y) > 1) {
				path_create = true;
				path_end_x = sight_unit_seen_x;
				path_end_y = sight_unit_seen_y;
			}
		}
		else {
			pathing = false;
		}
		
		// Targeting Behaviour
		if (point_distance(x, y - (temp_combat_unit_height / 2), sight_unit_seen_x, sight_unit_seen_y) > (sight_radius / 2)) {
			// Target Unit Last Seen
			targeting = true;
				
			target_x = sight_unit_seen_x;
			target_y = sight_unit_seen_y;
		}
	}
	
	// Attack Behaviour
	if (temp_aggro_behaviour_active) {
		// Targeting Behaviour
		targeting = true;
				
		// Find Target Center
		var temp_unit_height = sight_unit_nearest.hitbox_right_bottom_y_offset - sight_unit_nearest.hitbox_left_top_y_offset;
		target_x = sight_unit_nearest.x;
		target_y = sight_unit_nearest.y - (temp_unit_height / 2);
					
		// Valid Targeting Position
		if (alert >= alert_threshold) {
			if (!platform_free(x, y + 1, platform_list)) {
				// Set Aim Behaviour
				key_aim_press = true;
			}
		}
	}
}

// Inherit the parent event
event_inherited();