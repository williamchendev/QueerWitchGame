/// @description Unit Early Update Event
// performs the early calculations necessary for the Unit's behavior

// Camera Movement
if (camera_follow) {
	var target_pos_x = x;
	var target_pos_y = y;
	
	// UI Camera Modes
	if (gui_mode == "inventory") {
		// Inventory
		if (unit_inventory != noone) {
			target_pos_x = x + ((unit_inventory.inventory_width / 2) * unit_inventory.inventory_grid_size) + unit_inventory.inventory_offset_size;
			target_pos_y = y + ((((unit_inventory.inventory_height / 2) * unit_inventory.inventory_grid_size) + unit_inventory.inventory_offset_size) * 0.6);
		}
	}
	else if (gui_mode == "targeting") {
		// Targeting
		if (targets != noone) {
			if (targets[target] != noone) {
				target_pos_x = round(lerp(x, targets[target].x, 0.5));
				target_pos_y = round(lerp(y, targets[target].y, 0.5));
			}
		}
	}
	
	var camera = view_camera[0];
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);
	var cam_x = camera_get_view_x(camera);
	var cam_y = camera_get_view_y(camera);
	
	var cam_target_x = lerp(cam_x, target_pos_x - (cam_width / 2), camera_follow_spd);
	var cam_target_y = lerp(cam_y, target_pos_y - (cam_height / 2) + camera_y_offset, camera_follow_spd);
	
	camera_set_view_pos(camera, cam_target_x, cam_target_y);
}