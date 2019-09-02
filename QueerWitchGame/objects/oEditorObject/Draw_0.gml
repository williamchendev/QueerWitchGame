/// @description Editor Object Draw
// Draws the Editor Object to the screen

// Draw Object
if (object_editor_id != -1) {
	// Sprite Variable
	var temp_sprite_index = global.editor_data[object_editor_id, 1];
	
	// Draw Select Behaviour
	if (selected) {
		// Mouse Hold Behaviour
		if (mouse_press) {
			// Mouse Modes
			if (mouse_mode == 0 or mouse_mode == 3) {
				// Rotation or Move
				draw_sprite_ext(temp_sprite_index, 0, old_x, old_y, object_x_scale, object_y_scale, old_rotation, c_white, 0.4);
			}
			else if (mouse_mode != -1) {
				// Scale
				var temp_old_x = old_x;
				var temp_old_y = old_y;
				if (mouse_mode == 1) {
					temp_old_y = y
				}
				else {
					temp_old_x = x;
				}
				
				draw_sprite_ext(temp_sprite_index, 0, temp_old_x, temp_old_y, old_scale_x, old_scale_y, object_rotation, c_white, 0.4);
				draw_sprite_ext(temp_sprite_index, 0, x, y, object_x_scale, object_y_scale, object_rotation, c_white, 1);
				return;
			}
		}
	}
	
	// Draw Object with Object Properties
	draw_sprite_ext(temp_sprite_index, 0, x, y, object_x_scale, object_y_scale, object_rotation, c_white, 1);
}