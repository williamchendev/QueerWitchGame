/// @description Editor Object Update
// Calculates the functionality and behaviour of the Editor Object

// Selected Behaviour
if (selected) {
	// Get Sprite Index
	var temp_sprite_index = global.editor_data[object_editor_id, 1];
	
	// Mouse Behaviour
	if (!mouse_press) {
		// Check Mouse Mode
		mouse_mode = -1;
		if (oEditor.editor_tools.util_type == 0) {
			// Editor Select
			if ((mouse_room_x() > (x + edge_a)) and (mouse_room_x() < (x + edge_b))) {
				if ((mouse_room_y() > (y + edge_c)) and (mouse_room_y() < (y + edge_d))) {
					// Check Edges and Mids for Editor Cursor Mode
					if (point_distance(mouse_room_x(), mouse_room_y(), x + edge_a, y + edge_c) < mouse_edge_bounds) {
						// Left Top Corner
						mouse_mode = 0;
					}
					else if (point_distance(mouse_room_x(), mouse_room_y(), x + edge_b, y + edge_c) < mouse_edge_bounds) {
						// Right Top Corner
						mouse_mode = 0;
					}
					else if (point_distance(mouse_room_x(), mouse_room_y(), x + edge_a, y + edge_d) < mouse_edge_bounds) {
						// Left Bottom Corner
						mouse_mode = 0;
					}
					else if (point_distance(mouse_room_x(), mouse_room_y(), x + edge_b, y + edge_d) < mouse_edge_bounds) {
						// Right Bottom Corner
						mouse_mode = 0;
					}
					else if (abs((x + edge_a) - mouse_room_x()) < mouse_mid_bounds) {
						// Left Horizontal Line
						mouse_mode = 1;
					}
					else if (abs((x + edge_b) - mouse_room_x()) < mouse_mid_bounds) {
						// Right Horizontal Line
						mouse_mode = 1;
					}
					else if (abs((y + edge_c) - mouse_room_y()) < mouse_mid_bounds) {
						// Top Vertical Line
						mouse_mode = 2;
					}
					else if (abs((y + edge_d) - mouse_room_y()) < mouse_mid_bounds) {
						// Bottom Vertical Line
						mouse_mode = 2;
					}
				}
			}
		}
		else if (oEditor.editor_tools.util_type == 1) {
			// Editor Move
			if ((mouse_room_x() > (x + edge_a)) and (mouse_room_x() < (x + edge_b))) {
				if ((mouse_room_y() > (y + edge_c)) and (mouse_room_y() < (y + edge_d))) {
					mouse_mode = 3;
				}
			}
			
			// If mouse was outside of object mask, deselect object
			if (mouse_mode == -1) {
				if (mouse_check_button_pressed(mb_left)) {
					selected = false;
				}
			}
		}
		
		// Check if user clicked
		if (mouse_mode != -1) {
			if (mouse_check_button_pressed(mb_left)) {
				// Set Mouse Press variables
				mouse_press = true;
				mouse_press_x = mouse_room_x();
				mouse_press_y = mouse_room_y();
				
				// Old Object Variables
				old_x = x;
				old_y = y;
				old_mid_x = mid_a;
				old_mid_y = mid_b;
				old_rotation = object_rotation;
				
				// Disable editor click
				oEditor.editor_click = false;
			}
		}
	}
	else {
		// Check if user is still pressing down
		if (mouse_check_button(mb_left)) {
			// Mouse Hold Behaviour
			if (mouse_mode == 0) {
				// Rotate
				var temp_old_rotate = point_direction(old_x + old_mid_x, old_y + old_mid_y, mouse_press_x, mouse_press_y);
				var temp_new_rotate = point_direction(old_x + old_mid_x, old_y + old_mid_y, mouse_room_x(), mouse_room_y());
				var temp_object_rotation = old_rotation + (temp_new_rotate - temp_old_rotate);
				
				// Calculate Center Rotate Offset
				var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index) - sprite_get_xoffset(temp_sprite_index);
				var temp_bbox_right = sprite_get_bbox_right(temp_sprite_index) - sprite_get_xoffset(temp_sprite_index);
				var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index) - sprite_get_yoffset(temp_sprite_index);
				var temp_bbox_bottom = sprite_get_bbox_bottom(temp_sprite_index) - sprite_get_yoffset(temp_sprite_index);
				
				var temp_bbox_half_x = ((temp_bbox_right - temp_bbox_left) / 2.0) + temp_bbox_left;
				var temp_bbox_half_y = ((temp_bbox_bottom - temp_bbox_top) / 2.0) + temp_bbox_top;
				
				var temp_mid_dis = point_distance(0, 0, temp_bbox_half_x, temp_bbox_half_y);
				var temp_mid_dir = point_direction(temp_bbox_half_x, temp_bbox_half_y, 0, 0);
				
				// Update Rotation and Position
				if (abs(angle_difference(temp_object_rotation, 0)) < 5) {
					object_rotation = 0;
				}
				else {
					object_rotation = temp_object_rotation;
				}
				
				x = (old_x + old_mid_x) + lengthdir_x(temp_mid_dis, temp_mid_dir + object_rotation);
				y = (old_y + old_mid_y) + lengthdir_y(temp_mid_dis, temp_mid_dir + object_rotation);
			}
			else if (mouse_mode <= 2) {
				// Scale
				if (mouse_mode == 1) {
					
				}
			}
			else if (mouse_mode == 3) {
				// Move
				if (keyboard_check(vk_control)) {
					// Free Move
					x = old_x - (mouse_press_x - mouse_room_x());
					y = old_y - (mouse_press_y - mouse_room_y());
				}
				else {
					// Snap Move
					var temp_free_x = old_x - (mouse_press_x - mouse_room_x());
					var temp_free_y = old_y - (mouse_press_y - mouse_room_y());
					
					// Get Offset
					var temp_obj_x_offset = 0;
					var temp_obj_y_offset = 0;
					if (array_length_2d(global.editor_data, object_editor_id) >= 4) {
						temp_obj_x_offset = global.editor_data[object_editor_id, 2];
						temp_obj_y_offset = global.editor_data[object_editor_id, 3];
					}
					
					// Set Position of Object
					x = (floor(temp_free_x / 48) * 48) + temp_obj_x_offset;
					y = (floor(temp_free_y / 48) * 48) + temp_obj_y_offset;
				}
			}
		}
		else {
			mouse_press = false;
			mouse_mode = -1;
		}
	}
	
	// Set Editor Cursor
	var temp_editor_mouse_mode = mouse_mode;
	if (temp_editor_mouse_mode > 1) {
		temp_editor_mouse_mode -= 1;
	}
	oEditor.editor_cursor = temp_editor_mouse_mode;
	
	// Delete Object
	if (keyboard_check_pressed(vk_delete)) {
		instance_destroy();
	}
	
	// Set Edges and Mids
	var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index);
	var temp_bbox_right = sprite_get_bbox_right(temp_sprite_index);
	var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index);
	var temp_bbox_bottom = sprite_get_bbox_bottom(temp_sprite_index);
	
	temp_bbox_left -= sprite_get_xoffset(temp_sprite_index);
	temp_bbox_bottom -= sprite_get_yoffset(temp_sprite_index);
	temp_bbox_right -= sprite_get_xoffset(temp_sprite_index);
	temp_bbox_top -= sprite_get_yoffset(temp_sprite_index);
	
	var temp_point1_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_top);
	var temp_point1_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_top);
	var temp_point2_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_top);
	var temp_point2_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_top);
	var temp_point3_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_bottom);
	var temp_point3_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_bottom);
	var temp_point4_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_bottom);
	var temp_point4_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_bottom);
	
	var temp_left_top_x_offset = lengthdir_x(temp_point1_dis, temp_point1_angle + object_rotation);
	var temp_left_top_y_offset = lengthdir_y(temp_point1_dis, temp_point1_angle + object_rotation);
	var temp_right_top_x_offset = lengthdir_x(temp_point2_dis, temp_point2_angle + object_rotation);
	var temp_right_top_y_offset = lengthdir_y(temp_point2_dis, temp_point2_angle + object_rotation);
	var temp_right_bottom_x_offset = lengthdir_x(temp_point3_dis, temp_point3_angle + object_rotation);
	var temp_right_bottom_y_offset = lengthdir_y(temp_point3_dis, temp_point3_angle + object_rotation);
	var temp_left_bottom_x_offset = lengthdir_x(temp_point4_dis, temp_point4_angle + object_rotation);
	var temp_left_bottom_y_offset = lengthdir_y(temp_point4_dis, temp_point4_angle + object_rotation);
	
	edge_a = min(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
	edge_b = max(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
	edge_c = min(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);
	edge_d = max(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);
	
	var temp_bbox_half_x = ((edge_b - edge_a) / 2.0) + edge_a;
	var temp_bbox_half_y = ((edge_d - edge_c) / 2.0) + edge_c;
	
	mid_a = temp_bbox_half_x;
	mid_b = temp_bbox_half_y;
	
	edges_calc = true;
}

// Set Mask Behaviour
image_angle = object_rotation;
image_xscale = object_x_scale;
image_yscale = object_y_scale;