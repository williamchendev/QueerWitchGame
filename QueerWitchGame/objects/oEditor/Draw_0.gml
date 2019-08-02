/// @description Level Editor Draw Event
// Draws the Level Editor to the screen

// *TEMP*
if (!menu_screen) {
	// Grid Pattern
	draw_set_alpha(1);
	if (editor_grid) {
		draw_set_color(c_white);
		var grid_draw_start_x = ((floor(oGameManager.camera_x / 48) - 4) * 48);
		var grid_draw_start_y = ((floor(oGameManager.camera_y / 48) - 4) * 48);
		for (var h = 0; h < (oGameManager.camera_height / 48) + 8; h++) {
			for (var w = 0; w < (oGameManager.camera_width / 48) + 8; w++) {
				var grid_draw_temp_x = grid_draw_start_x + (w * 48);
				var grid_draw_temp_y = grid_draw_start_y + (h * 48);
				draw_sprite(sEditorGrid, 0, grid_draw_temp_x, grid_draw_temp_y);
			}
		}
	}
	
	// Draw Block Bounds
	draw_set_color(c_red);
	draw_line(0, 0, 0, block_height * 48);
	draw_line(0, 0, block_width * 48, 0);
	draw_line(0, block_height * 48, block_width * 48, block_height * 48);
	draw_line(block_width * 48, 0, block_width * 48, block_height * 48);
	
	draw_set_color(c_white);
}