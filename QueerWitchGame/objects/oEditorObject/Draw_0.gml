/// @description Editor Object Draw
// Draws the Editor Object to the screen

// Draw Object
if (object_editor_id != -1) {
	// Sprite Variable
	var temp_sprite_index = global.editor_data[object_editor_id, 1];
	
	// Draw Select Behaviour
	if (selected) {
		// Mouse Hold Behaviour
		if (mouse_check_button(mb_left)) {
			// Mouse Modes
			if (mouse_mode == 0) {
				// Rotation
				draw_sprite_ext(temp_sprite_index, 0, old_x, old_y, object_x_scale, object_y_scale, old_rotation, c_white, 0.4);
			}	
		}
	}
	
	// Draw Object with Object Properties
	draw_sprite_ext(temp_sprite_index, 0, x, y, object_x_scale, object_y_scale, object_rotation, c_white, 1);
}