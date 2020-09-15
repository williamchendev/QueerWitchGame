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
	
	// AI Behaviour Switch
	if (pathing and ai_command) {
		// Targeting Behaviour
		key_aim_press = false;
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
	else if (sight_unit_seen and ai_hunt) {
		// Last Seen AI Variables
		var temp_combat_unit_height = hitbox_right_bottom_y_offset - hitbox_left_top_y_offset;
		
		// Last Seen Movement Behaviour
		if (point_distance(x, y - (temp_combat_unit_height / 2), sight_unit_seen_x, sight_unit_seen_y) > (sight_radius / 4)) {
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
}

// Inherit the parent event
event_inherited();

