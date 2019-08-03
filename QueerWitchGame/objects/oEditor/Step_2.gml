/// @description Level Editor Late Update Event
// Places Tiles and Objects from the selected Menu in the Level Editor

// Editor Mode Behaviours
if (editor_mode == editortypes.block) {
	// Check if Editor was clicked and viable
	if (editor_click) {
		if (editor_objects.selected_menu == 1) {
			// Tileset Selected
			if (mouse_check_button(mb_left)) {
				// Check if within bounds of the editor block
				if (mouse_room_x() >= 0 and mouse_room_x() < (block_width * 48)) {
					if (mouse_room_y() >= 0 and mouse_room_y() < (block_height * 48)) {
						// Set the Tile
						var temp_snap_x = floor(mouse_room_x() / 48);
						var temp_snap_y = floor(mouse_room_y() / 48);
						tilesetSet(block_tileset, temp_snap_x, temp_snap_y, editor_objects.selected_index);
					}
				}
			}
		}
	}
}