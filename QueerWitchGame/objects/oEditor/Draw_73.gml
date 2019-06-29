/// @description Level Editor Draw End Event
// Draws the UI and Level Editor to the screen

// Menu
if (menu_screen) {
	// Level Editor Title
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fDiest64);
	
	draw_text(x + 14, y + 12, "Queer Witch Level Editor v0.2");
	draw_rectangle(x + 8, y + 10, x + 188, y + 28, true);
	
	// Level Editor Options
	draw_set_font(fInnoFont);
	
	draw_text(x + 14, y + 34, "Play Demo");
	draw_text(x + 14, y + 52, "New Level");
	draw_text(x + 14, y + 70, "Open Level");
	draw_text(x + 14, y + 88, "New Block");
	draw_text(x + 14, y + 106, "Open Block");
	
	// Play Demo Option
	draw_set_alpha(menu_option_play_demo_alpha);
	draw_set_color(c_white);
	draw_rectangle(x + 8, y + 32, x + 8 + (menu_option_play_demo_alpha * 55), y + 50, false);
	draw_set_color(c_black);
	draw_text(x + 14, y + 34, "Play Demo");
	//draw_rectangle(x + 8, y + 32, x + 63, y + 50, true);
	
	// New Level Option
	draw_set_alpha(menu_option_new_level_alpha);
	draw_set_color(c_white);
	draw_rectangle(x + 8, y + 50, x + 8 + (menu_option_new_level_alpha * 57), y + 68, false);
	draw_set_color(c_black);
	draw_text(x + 14, y + 52, "New Level");
	//draw_rectangle(x + 8, y + 50, x + 65, y + 68, true);
	
	// Open Level Option
	draw_set_alpha(menu_option_open_level_alpha);
	draw_set_color(c_white);
	draw_rectangle(x + 8, y + 68, x + 8 + (menu_option_open_level_alpha * 58), y + 86, false);
	draw_set_color(c_black);
	draw_text(x + 14, y + 70, "Open Level");
	//draw_rectangle(x + 8, y + 68, x + 66, y + 86, true);
	
	// New Block Option
	draw_set_alpha(menu_option_new_block_alpha);
	draw_set_color(c_white);
	draw_rectangle(x + 8, y + 86, x + 8 + (menu_option_new_block_alpha * 56), y + 104, false);
	draw_set_color(c_black);
	draw_text(x + 14, y + 88, "New Block");
	//draw_rectangle(x + 8, y + 86, x + 64, y + 104, true);
	
	// Open Block Option
	draw_set_alpha(menu_option_open_block_alpha);
	draw_set_color(c_white);
	draw_rectangle(x + 8, y + 104, x + 8 + (menu_option_open_block_alpha * 57), y + 124, false);
	draw_set_color(c_black);
	draw_text(x + 14, y + 106, "Open Block");
	//draw_rectangle(x + 8, y + 104, x + 65, y + 124, true);
	
	// Minor Menu Screen
	draw_set_alpha(1);
	var temp_minor_menu_x = oGameManager.camera_x + (oGameManager.camera_width / 2);
	var temp_minor_menu_y = oGameManager.camera_y + (oGameManager.camera_height / 2);
	
	// New Block Menu Screen
	if (new_block_screen) {
		// Draw Menu Background
		draw_set_color(c_black);
		draw_roundrect(temp_minor_menu_x - 70, temp_minor_menu_y - 50, temp_minor_menu_x + 70, temp_minor_menu_y + 30, false);
		draw_set_color(c_white);
		draw_roundrect(temp_minor_menu_x - 70, temp_minor_menu_y - 50, temp_minor_menu_x + 70, temp_minor_menu_y + 30, true);
		
		// Draw Menu Text
		draw_text(temp_minor_menu_x - 58, temp_minor_menu_y - 42, "New Block");
		draw_text(temp_minor_menu_x - 58, temp_minor_menu_y - 24, "Width: " + block_width_select);
		//draw_rectangle(temp_minor_menu_x - 60, temp_minor_menu_y - 24, temp_minor_menu_x - 5, temp_minor_menu_y - 10, true);
		draw_text(temp_minor_menu_x + 4, temp_minor_menu_y - 24, "Height: " + block_height_select);
		//draw_rectangle(temp_minor_menu_x + 2, temp_minor_menu_y - 24, temp_minor_menu_x + 60, temp_minor_menu_y - 10, true);
		
		// Draw Menu Selection
		if (block_select == 0) {
			draw_line(temp_minor_menu_x - 61, temp_minor_menu_y - 10, temp_minor_menu_x - 12, temp_minor_menu_y - 10);
		}
		else if (block_select == 1) {
			draw_line(temp_minor_menu_x + 1, temp_minor_menu_y - 10, temp_minor_menu_x + 52, temp_minor_menu_y - 10);
		}
	}
}
else {
	
	// Grid Pattern
	if (editor_grid) {
		draw_set_alpha(1);
		draw_set_color(c_white);
		var grid_draw_start_x = ((floor(oGameManager.camera_x / 48) - 4) * 48);
		var grid_draw_start_y = ((floor(oGameManager.camera_y / 48) - 4) * 48);
		for (var h = 0; h < (oGameManager.camera_height / 48) + 8; h++) {
			for (var w = 0; w < (oGameManager.camera_width / 48) + 8; w++) {
				var grid_draw_temp_x = grid_draw_start_x + (w * 48);
				var grid_draw_temp_y = grid_draw_start_y + (h * 48);
				draw_line(grid_draw_temp_x, grid_draw_temp_y, grid_draw_temp_x + 4, grid_draw_temp_y);
				draw_line(grid_draw_temp_x, grid_draw_temp_y, grid_draw_temp_x, grid_draw_temp_y + 4);
				draw_line(grid_draw_temp_x + 48, grid_draw_temp_y + 48, grid_draw_temp_x + 43, grid_draw_temp_y + 48);
				draw_line(grid_draw_temp_x + 48, grid_draw_temp_y + 48, grid_draw_temp_x + 48, grid_draw_temp_y + 43);
			}
		}
	}
	
}