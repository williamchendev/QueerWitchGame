/// @description Unit Late Update Event
// performs the late calculations necessary for the Unit's behavior

/*
if (camera_follow) {
	// Camera Variables
	var temp_camera = view_camera[0];
	var temp_camera_width = camera_get_view_width(temp_camera);
	var temp_camera_height = camera_get_view_height(temp_camera);
	
	var target_pos_x = x + (image_xscale * 120);
	var target_pos_y = y;
	
	// Camera Targeting Behaviour
	if (instance_exists(oTargetUI)) {
		if (oTargetUI.target != noone) {
			if (instance_exists(oTargetUI.target)) {
				target_pos_x = oTargetUI.target.x;
				target_pos_y = oTargetUI.target.y;
			}
		}
	}
	else if (target != noone) {
		if (instance_exists(target)) {
			if (abs(x - target.x) < temp_camera_width - 30) {
				if (abs(y - target.y) < temp_camera_height - 48) {
					target_pos_x = lerp(x, target.x, 0.5);
					target_pos_y = lerp(y, target.y, 0.5);
				}
			}
		}
	}
	
	// Updating Camera Position
	camera_x = lerp(camera_x, target_pos_x - (temp_camera_width / 2), camera_follow_spd);
	camera_y = lerp(camera_y, target_pos_y - (temp_camera_height / 2) + camera_y_offset, camera_follow_spd);
	
	camera_set_view_pos(temp_camera, camera_x, camera_y);
}
*/

// Update Unit Inventory
if (inventory != noone) {
	// Sprite Variables
	var temp_y_scale = (image_yscale * draw_yscale);
	var temp_mask_height = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index);
	
	// Set Inventory visual features
	inventory.x = lerp(inventory.x, x + inventory_x_offset, inventory_lerp_spd * global.realdeltatime);
	inventory.y = lerp(inventory.y, y + lengthdir_y(temp_mask_height * 0.5 * temp_y_scale, draw_angle + 90), inventory_lerp_spd * global.realdeltatime);
	inventory.draw_inventory = inventory_show;
}

// Reset Room
if (keyboard_check_pressed(ord("L")) or (knockout_timer <= 0)) {
	ds_list_destroy(game_manager.instantiated_units);
	game_manager.instantiated_units = ds_list_create();
	room_restart();
}