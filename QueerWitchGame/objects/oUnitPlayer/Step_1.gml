/// @description Unit Early Update Event
// performs the early calculations necessary for the Unit's behavior

// Camera Movement
if (camera_follow) {
	var target_pos_x = x;
	var target_pos_y = y;
	
	// UI Camera Modes
	if (inventory_show and canmove) {
		// Inventory
		if (inventory != noone) {
			target_pos_x = inventory.x + ((inventory.inventory_width / 2) * inventory.inventory_grid_size) + inventory.inventory_offset_size;
			target_pos_y = inventory.y + ((inventory.inventory_height / 2) * inventory.inventory_grid_size) + inventory.inventory_offset_size;
		}
	}
	else {
		// Check Lock On Enemies
		var temp_lockon_index = 0;
		var temp_lockon_units = noone;
		for (var i = 0; i < instance_number(oUnitCombat); i++) {
			var temp_unit = instance_find(oUnitCombat, i);
			if (instance_exists(temp_unit)) {
				// Check if Target Exists
				if (temp_unit.target != noone) {
					if (instance_exists(temp_unit.target)) {
						// Valid Target
						var temp_unit_target = temp_unit.target;
						if (team_id == temp_unit_target.team_id) {
							// Index Unit as Locked On Enemy
							if (point_distance(x, y, temp_unit.x, temp_unit.y) < camera_combat_lockon_distance) {
								temp_lockon_units[temp_lockon_index] = temp_unit;
								temp_lockon_index++;
							}
						}
					}
				}
			}
		}
		
		// Combat Camera Mode Check
		if (temp_lockon_index > 0) {
			// Distance Check
			var temp_min_camera_x = x;
			var temp_min_camera_y = y;
			var temp_max_camera_x = x;
			var temp_max_camera_y = y;
			for (var q = 0; q < array_length_1d(temp_lockon_units); q++) {
				temp_min_camera_x = min(temp_min_camera_x, temp_lockon_units[q].x);
				temp_min_camera_y = min(temp_min_camera_y, temp_lockon_units[q].y);
				temp_max_camera_x = max(temp_max_camera_x, temp_lockon_units[q].x);
				temp_max_camera_y = max(temp_max_camera_y, temp_lockon_units[q].y);
			}
			
			// Calculate Average
			target_pos_x = lerp(temp_min_camera_x, temp_max_camera_x, 0.5);
			target_pos_y = lerp(temp_min_camera_y, temp_max_camera_y, 0.5);
			
			// Calculate Spacing
			
		}
	}
	
	var camera = view_camera[0];
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);
	var cam_x = camera_x;
	var cam_y = camera_y;
	
	var cam_target_x = lerp(cam_x, target_pos_x - (cam_width / 2), camera_follow_spd);
	var cam_target_y = lerp(cam_y, target_pos_y - (cam_height / 2) + camera_y_offset, camera_follow_spd);
	
	camera_set_view_pos(camera, cam_target_x, cam_target_y);
	
	camera_x = cam_target_x;
	camera_y = cam_target_y;
}