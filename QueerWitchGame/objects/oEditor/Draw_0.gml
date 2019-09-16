/// @description Level Editor Draw Event
// Draws the Level Editor to the screen

// *TEMP*
if (editor_mode == editortypes.block) {
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
	
	// Skip Drawing Cursor
	if (instance_exists(oEditorWindow)) {
		return;
	}
	
	// Draw Selected Object at Cursor
	var temp_snap_x = (floor(mouse_room_x() / 48) * 48);
	var temp_snap_y = (floor(mouse_room_y() / 48) * 48);
	
	// Cursor Draw Behaviour
	if (editor_tools.util_type == 2) {
		// Draw Mode Selected
		if (editor_objects.selected_menu != -1 and editor_objects.selected_index != -1) {
			if (editor_objects.selected_menu == 1) {
				// Tileset Cursor
				if (mouse_room_x() >= 0 and mouse_room_x() < (block_width * 48)) {
					if (mouse_room_y() >= 0 and mouse_room_y() < (block_height * 48)) {
						if (editor_objects.selected_index == 0) {
							// Draw Empty
							draw_sprite(sDebugEmpty, 1, temp_snap_x, temp_snap_y);
						}
						else {
							// Draw Tile
							draw_sprite_ext(global.editor_data[global.editor_data_categories_length + block_tileset_index, 0], editor_objects.selected_index - 1, temp_snap_x, temp_snap_y, 1, 1, 0, c_white, 0.6);
						}
					}
				}
			}
			else {
				// Object Cursor
				var temp_obj_x_offset = 0;
				var temp_obj_y_offset = 0;
				if (array_length_2d(global.editor_data, (editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index) >= 5) {
					temp_obj_x_offset = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 3];
					temp_obj_y_offset = global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 4];
				}
				var temp_cursor_x = mouse_room_x();
				var temp_cursor_y = mouse_room_y();
				if (editor_snap) {
					temp_cursor_x = temp_snap_x + temp_obj_x_offset;
					temp_cursor_y = temp_snap_y + temp_obj_y_offset;
				}
				draw_sprite_ext(global.editor_data[(editor_objects.selected_menu * global.editor_data_categories_length) + editor_objects.selected_index, 1], 0, temp_cursor_x, temp_cursor_y, 1, 1, 0, c_white, 0.6);
			}
		}
	}
	else if (editor_tools.util_type == 3) {
		draw_sprite(sEditorUtil, 3, mouse_room_x(), mouse_room_y());
	}
}

// Draw Editor Cursor
if (editor_cursor != -1) {
	draw_sprite(sEditorCursor, editor_cursor, mouse_room_x(), mouse_room_y());
}