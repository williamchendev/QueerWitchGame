/// @description Unit Early Update Event
// performs the early calculations necessary for the Unit's behavior

// Camera Movement
if (camera_follow) {
	var target_pos_x = x + (sign(abs(x_velocity) * image_xscale) * camera_moving_x_offset * (1 - key_aim_press));
	var target_pos_y = y;
	
	// UI Camera Modes
	if (canmove) {
		if (inventory_show) {
			// Inventory
			if (inventory != noone) {
				target_pos_x = inventory.x + ((inventory.inventory_width / 2) * inventory.inventory_grid_size) + inventory.inventory_offset_size;
				target_pos_y = inventory.y + ((inventory.inventory_height / 2) * inventory.inventory_grid_size) + inventory.inventory_offset_size;
			}
		}
		else if (!camera_debug_gif_mode) {
			// Check Lock On Enemies
			var temp_lockon_index = 0;
			var temp_lockon_closest_index = 0;
			var temp_lockon_units = noone;
			for (var i = 0; i < instance_number(oUnitCombat); i++) {
				var temp_unit = instance_find(oUnitCombat, i);
				if (instance_exists(temp_unit)) {
					// Valid Target
					if (team_id != temp_unit.team_id) {
						// Check if within Camera Mask
						var temp_within_camera = collision_rectangle(game_manager.camera_x + camera_lockon_bounds, game_manager.camera_y + camera_lockon_bounds, game_manager.camera_x + game_manager.camera_width - camera_lockon_bounds, game_manager.camera_y + game_manager.camera_height - camera_lockon_bounds, temp_unit, false, true);
						if (temp_within_camera) {
							// Index Unit
							temp_lockon_units[temp_lockon_index] = temp_unit;
							if (point_distance(x, y, temp_unit.x, temp_unit.y) < point_distance(x, y, temp_lockon_units[temp_lockon_closest_index].x, temp_lockon_units[temp_lockon_closest_index].y)) {
								temp_lockon_closest_index = temp_lockon_index;
							}
							temp_lockon_index++;
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
				var temp_target_pos_x_copy = target_pos_x;
				target_pos_x = lerp(temp_min_camera_x, temp_max_camera_x, 0.5);
				target_pos_y = lerp(temp_min_camera_y, temp_max_camera_y, 0.5);
			
				// Lerp to Player
				if ((temp_target_pos_x_copy > temp_min_camera_x) and (temp_target_pos_x_copy < temp_max_camera_x)) {
					target_pos_x = lerp(target_pos_x, temp_target_pos_x_copy + (image_xscale * camera_moving_x_offset), 0.5);
				}
			
				// Lerp to Nearest Enemy
				target_pos_x = lerp(target_pos_x, temp_lockon_units[temp_lockon_closest_index].x, 0.3);
			}
		}
	}
	
	// Establish Camera Variables
	var camera = view_camera[0];
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);
	var cam_x = camera_x;
	var cam_y = camera_y;
	
	if (camera_lock) {
		target_pos_x = camera_lock_x;
		target_pos_y = camera_lock_y - camera_y_offset;
	}
	
	var cam_target_x = lerp(cam_x, target_pos_x - (cam_width / 2), camera_follow_spd);
	var cam_target_y = lerp(cam_y, target_pos_y - (cam_height / 2) + camera_y_offset, camera_follow_spd);
	
	// Clamp Player Spacing
	cam_target_x = clamp(cam_target_x, x + camera_horizontal_spacing - game_manager.camera_width, x - camera_horizontal_spacing);
	cam_target_y = clamp(cam_target_y, y + camera_vertical_spacing - game_manager.camera_height, y - camera_vertical_spacing);
	
	// Save Camera Position
	camera_x = cam_target_x;
	camera_y = cam_target_y;
	
	// Camera Screen Shake
	if (camera_screen_shake) {
		camera_screen_shake_timer += global.realdeltatime * camera_screen_shake_spd;
		if (camera_screen_shake_timer >= 1) {
			camera_screen_shake_timer--;
			var temp_screen_shake_size = camera_screen_shake_sml_range;
			if (camera_screen_shake_lrg) {
				temp_screen_shake_size = camera_screen_shake_lrg_range;
			}
			var temp_random_screen_shake_angle = random(2 * pi);
			camera_screen_shake_x = cos(temp_random_screen_shake_angle) * temp_screen_shake_size;
			camera_screen_shake_y = sin(temp_random_screen_shake_angle) * temp_screen_shake_size;
		}
	}
	else {
		camera_screen_shake_x = lerp(camera_screen_shake_x, 0, global.realdeltatime * camera_screen_shake_reset_spd);
		camera_screen_shake_y = lerp(camera_screen_shake_y, 0, global.realdeltatime * camera_screen_shake_reset_spd);
	}
	
	// Set Camera Position
	var temp_camera_set_x_pos = cam_target_x + camera_screen_shake_x;
	var temp_camera_set_y_pos = cam_target_y + camera_screen_shake_y;
	if (camera_room_clamp_x) {
		temp_camera_set_x_pos = clamp(temp_camera_set_x_pos, 0, room_width - game_manager.game_width);
	}
	if (camera_room_clamp_y) {
		temp_camera_set_x_pos = clamp(temp_camera_set_y_pos, 0, room_height - game_manager.game_height);
	}
	camera_set_view_pos(camera, temp_camera_set_x_pos, temp_camera_set_y_pos);
}