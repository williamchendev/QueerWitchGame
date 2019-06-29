/// @description Level Editor Update Event
// Calculates the functionality and behaviour of the Level Editor

// Menu
if (menu_screen) {
	// Minor Menu Screens
	if (new_block_screen) {
		if (mouse_check_button_pressed(mb_left)) {
			var temp_minor_menu_x = oGameManager.camera_x + (oGameManager.camera_width / 2);
			var temp_minor_menu_y = oGameManager.camera_y + (oGameManager.camera_height / 2);
			if (abs((temp_minor_menu_x - 32) - mouse_room_x()) < 28) and (abs((temp_minor_menu_y - 17) - mouse_room_y()) < 7) {
				block_select = 0;
			}
			else if (abs((temp_minor_menu_x + 32) - mouse_room_x()) < 28) and (abs((temp_minor_menu_y - 17) - mouse_room_y()) < 7) {
				block_select = 1;
			}
		}
		
		var temp_keyboard_num = keyboard_check_number();
		if (temp_keyboard_num != -1) {
			if (block_select == 0) {
				if (temp_keyboard_num != -2) {
					if (string_length(block_width_select) < 3) {
						if ((temp_keyboard_num == 0) and (block_width_select != "")) or (temp_keyboard_num != 0) {
							block_width_select += string(temp_keyboard_num);
						}
					}
				}
				else {
					if (string_length(block_width_select) > 0) {
						block_width_select = string_delete(block_width_select, string_length(block_width_select), 1);
					}
				}
			}
			else if (block_select == 1) {
				if (temp_keyboard_num != -2) {
					if (string_length(block_height_select) < 3) {
						if ((temp_keyboard_num == 0) and (block_height_select != "")) or (temp_keyboard_num != 0) {
							block_height_select += string(temp_keyboard_num);
						}
					}
				}
				else {
					if (string_length(block_height_select) > 0) {
						block_height_select = string_delete(block_height_select, string_length(block_height_select), 1);
					}
				}
			}
		}
		
		//menu_screen = false;
		//new_block_screen = false;
		//editor_mode = editormode.block;
	}
	else { 
		// Play Demo Option
		if (abs((x + 35) - mouse_room_x()) < 28) and (abs((y + 41) - mouse_room_y()) < 8) {
			if (menu_option_play_demo_alpha < 1) {
				menu_option_play_demo_alpha = menu_option_play_demo_alpha + 0.025;
				menu_option_play_demo_alpha *= 1.09;
			}
		}
		else {
			if (menu_option_play_demo_alpha > 0) {
				menu_option_play_demo_alpha = menu_option_play_demo_alpha - 0.01;
				menu_option_play_demo_alpha *= 0.9;
			}
		}
		menu_option_play_demo_alpha = clamp(menu_option_play_demo_alpha, 0, 1);
	
		// New Level Option
		if (abs((x + 37) - mouse_room_x()) < 30) and (abs((y + 59) - mouse_room_y()) < 8) {
			if (menu_option_new_level_alpha < 1) {
				menu_option_new_level_alpha = menu_option_new_level_alpha + 0.025;
				menu_option_new_level_alpha *= 1.09;
			}
		}
		else {
			if (menu_option_new_level_alpha > 0) {
				menu_option_new_level_alpha = menu_option_new_level_alpha - 0.01;
				menu_option_new_level_alpha *= 0.9;
			}
		}
		menu_option_new_level_alpha = clamp(menu_option_new_level_alpha, 0, 1);
	
		// Open Level Option
		if (abs((x + 37) - mouse_room_x()) < 29) and (abs((y + 77) - mouse_room_y()) < 8) {
			if (menu_option_open_level_alpha < 1) {
				menu_option_open_level_alpha = menu_option_open_level_alpha + 0.025;
				menu_option_open_level_alpha *= 1.09;
			}
		}
		else {
			if (menu_option_open_level_alpha > 0) {
				menu_option_open_level_alpha = menu_option_open_level_alpha - 0.01;
				menu_option_open_level_alpha *= 0.9;
			}
		}
		menu_option_open_level_alpha = clamp(menu_option_open_level_alpha, 0, 1);
	
		// New Block Option
		if (abs((x + 36) - mouse_room_x()) < 29) and (abs((y + 95) - mouse_room_y()) < 8) {
			if (menu_option_new_block_alpha < 1) {
				menu_option_new_block_alpha = menu_option_new_block_alpha + 0.025;
				menu_option_new_block_alpha *= 1.09;
			}
		
			// Click Event
			if (mouse_check_button_pressed(mb_left)) {
				new_block_screen = true;
			}
		}
		else {
			if (menu_option_new_block_alpha > 0) {
				menu_option_new_block_alpha = menu_option_new_block_alpha - 0.01;
				menu_option_new_block_alpha *= 0.9;
			}
		}
		menu_option_new_block_alpha = clamp(menu_option_new_block_alpha, 0, 1);
	
		// Open Block Option
		if (abs((x + 37) - mouse_room_x()) < 29) and (abs((y + 113) - mouse_room_y()) < 8) {
			if (menu_option_open_block_alpha < 1) {
				menu_option_open_block_alpha = menu_option_open_block_alpha + 0.025;
				menu_option_open_block_alpha *= 1.09;
			}
		}
		else {
			if (menu_option_open_block_alpha > 0) {
				menu_option_open_block_alpha = menu_option_open_block_alpha - 0.01;
				menu_option_open_block_alpha *= 0.9;
			}
		}
		menu_option_open_block_alpha = clamp(menu_option_open_block_alpha, 0, 1);
	}
}
else {
	if (editor_mode != editormode.text) {
		if (keyboard_check(ord("W"))) {
			y -= editor_spd;
		}
		else if (keyboard_check(ord("S"))) {
			y += editor_spd;
		}
	
		if (keyboard_check(ord("A"))) {
			x -= editor_spd;
		}
		else if (keyboard_check(ord("D"))) {
			x += editor_spd;
		}
	}
}

// Camera Movement
if (camera_follow) {
	var target_pos_x = x;
	var target_pos_y = y;
	
	var camera = view_camera[0];
	//var cam_width = camera_get_view_width(camera);
	//var cam_height = camera_get_view_height(camera);
	var cam_x = camera_get_view_x(camera);
	var cam_y = camera_get_view_y(camera);
	
	var cam_target_x = lerp(cam_x, target_pos_x, camera_follow_spd);
	var cam_target_y = lerp(cam_y, target_pos_y, camera_follow_spd);
	
	camera_set_view_pos(camera, cam_target_x, cam_target_y);
}