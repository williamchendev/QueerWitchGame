/// @description Editor Object Update
// Calculates the functionality and behaviour of the Editor Object

// Cease Behaviour if Editor Window Exists
if (instance_exists(oEditorWindow)) {
	return;
}

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
						scale_mode = false;
					}
					else if (abs((x + edge_b) - mouse_room_x()) < mouse_mid_bounds) {
						// Right Horizontal Line
						mouse_mode = 1;
						scale_mode = true;
					}
					else if (abs((y + edge_c) - mouse_room_y()) < mouse_mid_bounds) {
						// Top Vertical Line
						mouse_mode = 2;
						scale_mode = false;
					}
					else if (abs((y + edge_d) - mouse_room_y()) < mouse_mid_bounds) {
						// Bottom Vertical Line
						mouse_mode = 2;
						scale_mode = true;
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
				
				var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index) * object_x_scale;
				var temp_bbox_right = sprite_get_bbox_right(temp_sprite_index) * object_x_scale;
				var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index) * object_y_scale;
				var temp_bbox_bottom = sprite_get_bbox_bottom(temp_sprite_index) * object_y_scale;
	
				temp_bbox_left -= sprite_get_xoffset(temp_sprite_index) * object_x_scale;
				temp_bbox_bottom -= sprite_get_yoffset(temp_sprite_index) * object_y_scale;
				temp_bbox_right -= sprite_get_xoffset(temp_sprite_index) * object_x_scale;
				temp_bbox_top -= sprite_get_yoffset(temp_sprite_index) * object_y_scale;
	
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
				
				var temp_edge_a = min(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
				var temp_edge_b = max(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
				var temp_edge_c = min(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);
				var temp_edge_d = max(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);
				
				var temp_bbox_half_x = ((temp_edge_b - temp_edge_a) / 2.0) + temp_edge_a;
				var temp_bbox_half_y = ((temp_edge_d - temp_edge_c) / 2.0) + temp_edge_c;
				
				old_mid_x = temp_bbox_half_x;
				old_mid_y = temp_bbox_half_y;
				
				old_scale_x = object_x_scale;
				old_scale_y = object_y_scale;
				old_rotation = object_rotation;
				
				// Disable editor click
				oEditor.editor_click = false;
				
				// Perform Step if Scaling Mode
				if (mouse_mode == 1 or mouse_mode == 2) {
					event_perform(ev_step, 0);
				}
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
				var temp_bbox_left = (sprite_get_bbox_left(temp_sprite_index) * object_x_scale) - (sprite_get_xoffset(temp_sprite_index) * object_x_scale);
				var temp_bbox_right = (sprite_get_bbox_right(temp_sprite_index) * object_x_scale) - (sprite_get_xoffset(temp_sprite_index) * object_x_scale);
				var temp_bbox_top = (sprite_get_bbox_top(temp_sprite_index) * object_y_scale) - (sprite_get_yoffset(temp_sprite_index) * object_y_scale);
				var temp_bbox_bottom = (sprite_get_bbox_bottom(temp_sprite_index) * object_y_scale) - (sprite_get_yoffset(temp_sprite_index) * object_y_scale);
				
				var temp_bbox_half_x = ((temp_bbox_right - temp_bbox_left) / 2.0) + temp_bbox_left;
				var temp_bbox_half_y = ((temp_bbox_bottom - temp_bbox_top) / 2.0) + temp_bbox_top;
				
				var temp_mid_dis = point_distance(0, 0, temp_bbox_half_x, temp_bbox_half_y);
				var temp_mid_dir = point_direction(temp_bbox_half_x, temp_bbox_half_y, 0, 0);
				
				// Set Rotation
				if (abs(angle_difference(temp_object_rotation, 0)) < 5) {
					object_rotation = 0;
				}
				else {
					object_rotation = round(temp_object_rotation);
				}
				
				// Update Position
				x = (old_x + old_mid_x) + lengthdir_x(temp_mid_dis, temp_mid_dir + object_rotation);
				y = (old_y + old_mid_y) + lengthdir_y(temp_mid_dis, temp_mid_dir + object_rotation);
			}
			else if (mouse_mode <= 2) {
				// Scale
				var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index) - sprite_get_xoffset(temp_sprite_index);
				var temp_bbox_right = sprite_get_bbox_right(temp_sprite_index) - sprite_get_xoffset(temp_sprite_index);
				var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index) - sprite_get_yoffset(temp_sprite_index);
				var temp_bbox_bottom = sprite_get_bbox_bottom(temp_sprite_index) - sprite_get_yoffset(temp_sprite_index);
				
				var temp_scale_snap = !(keyboard_check(vk_control));
				
				// Scaling Mode
				if (mouse_mode == 1) {
					// Horizontal Scaling
					var temp_mask_width = temp_bbox_right - temp_bbox_left;
					
					// Variables
					var temp_bbox_old_scale_left = ((sprite_get_bbox_left(temp_sprite_index)) * old_scale_x) - (sprite_get_xoffset(temp_sprite_index) * old_scale_x);
					var temp_bbox_old_scale_right = ((sprite_get_bbox_right(temp_sprite_index) + 1) * old_scale_x) - (sprite_get_xoffset(temp_sprite_index) * old_scale_x);
					
					var temp_mouse_offset;
					var temp_x_position_update;
					
					// Left or Right Directional Scaling
					if (scale_mode) {
						// Drag Right Scaling
						if (sign(old_scale_x) >= 0) {
							// Calculate Drag Scale
							temp_mouse_offset = mouse_room_x() - (old_x + temp_bbox_old_scale_left);
							object_x_scale = (temp_mouse_offset / temp_mask_width);
							if (temp_scale_snap) {
								object_x_scale = round(object_x_scale);
							}
						
							// Update Position from Positive Scale
							var temp_bbox_new_scale_left = (sprite_get_bbox_left(temp_sprite_index) * object_x_scale) - (sprite_get_xoffset(temp_sprite_index) * object_x_scale);
							temp_x_position_update = (old_x + temp_bbox_old_scale_left) - temp_bbox_new_scale_left;
						}
						else {
							// Calculate Drag Scale
							temp_mouse_offset = mouse_room_x() - (old_x + temp_bbox_old_scale_right);
							object_x_scale = (temp_mouse_offset / temp_mask_width) * -1;
							if (temp_scale_snap) {
								object_x_scale = round(object_x_scale);
							}
						
							// Update Position from Negative Scale
							var temp_bbox_new_scale_right = ((sprite_get_bbox_right(temp_sprite_index) + 1) * object_x_scale) - (sprite_get_xoffset(temp_sprite_index) * object_x_scale);
							temp_x_position_update = (old_x + temp_bbox_old_scale_right) - temp_bbox_new_scale_right;
						}
					}
					else {
						// Drag Left Scaling
						if (sign(old_scale_x) >= 0) {
							// Calculate Drag Scale
							temp_mouse_offset = (old_x + temp_bbox_old_scale_right) - mouse_room_x();
							object_x_scale = (temp_mouse_offset / temp_mask_width);
							if (temp_scale_snap) {
								object_x_scale = round(object_x_scale);
							}
							
							// Update Position from Positive Scale
							var temp_bbox_new_scale_right = ((sprite_get_bbox_right(temp_sprite_index) + 1) * object_x_scale) - (sprite_get_xoffset(temp_sprite_index) * object_x_scale);
							temp_x_position_update = (old_x + temp_bbox_old_scale_right) - temp_bbox_new_scale_right;
						}
						else {			
							// Calculate Drag Scale
							temp_mouse_offset = (old_x + temp_bbox_old_scale_left) - mouse_room_x();
							object_x_scale = (temp_mouse_offset / temp_mask_width) * -1;
							if (temp_scale_snap) {
								object_x_scale = round(object_x_scale);
							}
							
							// Update Position from Negative Scale
							var temp_bbox_new_scale_left = ((sprite_get_bbox_left(temp_sprite_index)) * object_x_scale) - (sprite_get_xoffset(temp_sprite_index) * object_x_scale);
							temp_x_position_update = (old_x + temp_bbox_old_scale_left) - temp_bbox_new_scale_left;
						}
					}
					
					// Update X Position
					x = temp_x_position_update;
					
					// Clamp Scale
					if (abs(object_x_scale * temp_mask_width) < 1) {
						var temp_x_scale = object_x_scale;
						if (temp_x_scale == 0) {
							temp_x_scale = 1;
						}
						object_x_scale = sign(temp_x_scale) * (1 / temp_mask_width);
					}
				}
				else {
					// Vertical Scaling
					var temp_mask_height = temp_bbox_bottom - temp_bbox_top;
					
					// Variables
					var temp_bbox_old_scale_top = ((sprite_get_bbox_top(temp_sprite_index)) * old_scale_y) - (sprite_get_yoffset(temp_sprite_index) * old_scale_y);
					var temp_bbox_old_scale_bottom = ((sprite_get_bbox_bottom(temp_sprite_index) + 1) * old_scale_y) - (sprite_get_yoffset(temp_sprite_index) * old_scale_y);
					
					var temp_mouse_offset;
					var temp_y_position_update;
					
					// Top or Bottom Directional Scaling
					if (scale_mode) {
						// Drag Bottom Scaling
						if (sign(old_scale_y) >= 0) {
							// Calculate Drag Scale
							temp_mouse_offset = mouse_room_y() - (old_y + temp_bbox_old_scale_top);
							object_y_scale = (temp_mouse_offset / temp_mask_height);
							if (temp_scale_snap) {
								object_y_scale = round(object_y_scale);
							}
						
							// Update Position from Positive Scale
							var temp_bbox_new_scale_top = (sprite_get_bbox_top(temp_sprite_index) * object_y_scale) - (sprite_get_yoffset(temp_sprite_index) * object_y_scale);
							temp_y_position_update = (old_y + temp_bbox_old_scale_top) - temp_bbox_new_scale_top;
						}
						else {
							// Calculate Drag Scale
							temp_mouse_offset = mouse_room_y() - (old_y + temp_bbox_old_scale_bottom);
							object_y_scale = (temp_mouse_offset / temp_mask_height) * -1;
							if (temp_scale_snap) {
								object_y_scale = round(object_y_scale);
							}
						
							// Update Position from Negative Scale
							var temp_bbox_new_scale_bottom = ((sprite_get_bbox_bottom(temp_sprite_index) + 1) * object_y_scale) - (sprite_get_yoffset(temp_sprite_index) * object_y_scale);
							temp_y_position_update = (old_y + temp_bbox_old_scale_bottom) - temp_bbox_new_scale_bottom;
						}
					}
					else {
						// Drag Top Scaling
						if (sign(old_scale_y) >= 0) {
							// Calculate Drag Scale
							temp_mouse_offset = (old_y + temp_bbox_old_scale_bottom) - mouse_room_y();
							object_y_scale = (temp_mouse_offset / temp_mask_height);
							if (temp_scale_snap) {
								object_y_scale = round(object_y_scale);
							}
							
							// Update Position from Positive Scale
							var temp_bbox_new_scale_bottom = ((sprite_get_bbox_bottom(temp_sprite_index) + 1) * object_y_scale) - (sprite_get_yoffset(temp_sprite_index) * object_y_scale);
							temp_y_position_update = (old_y + temp_bbox_old_scale_bottom) - temp_bbox_new_scale_bottom;
						}
						else {			
							// Calculate Drag Scale
							temp_mouse_offset = (old_y + temp_bbox_old_scale_top) - mouse_room_y();
							object_y_scale = (temp_mouse_offset / temp_mask_height) * -1;
							if (temp_scale_snap) {
								object_y_scale = round(object_y_scale);
							}
							
							// Update Position from Negative Scale
							var temp_bbox_new_scale_top = ((sprite_get_bbox_top(temp_sprite_index)) * object_y_scale) - (sprite_get_yoffset(temp_sprite_index) * object_y_scale);
							temp_y_position_update = (old_y + temp_bbox_old_scale_top) - temp_bbox_new_scale_top;
						}
					}
					
					// Update Y Position
					y = temp_y_position_update;
					
					// Clamp Scale
					if (abs(object_y_scale * temp_mask_height) < 1) {
						var temp_y_scale = object_y_scale;
						if (temp_y_scale == 0) {
							temp_y_scale = 1;
						}
						object_y_scale = sign(temp_y_scale) * (1 / temp_mask_height);
					}
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
					if (array_length_2d(global.editor_data, object_editor_id) >= 5) {
						temp_obj_x_offset = global.editor_data[object_editor_id, 3];
						temp_obj_y_offset = global.editor_data[object_editor_id, 4];
					}
					
					// Set Position of Object
					x = (floor(temp_free_x / 48) * 48) + temp_obj_x_offset;
					y = (floor(temp_free_y / 48) * 48) + temp_obj_y_offset;
				}
			}
		}
		else {
			// Scaling Reset Position
			if (mouse_mode == 1) {
				y = old_y;
			}
			else if (mouse_mode == 2) {
				x = old_x;
			}
			
			// Reset Mouse Press
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
	var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index) * object_x_scale;
	var temp_bbox_right = (sprite_get_bbox_right(temp_sprite_index) + 1) * object_x_scale;
	var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index) * object_y_scale;
	var temp_bbox_bottom = (sprite_get_bbox_bottom(temp_sprite_index) + 1) * object_y_scale;
	
	temp_bbox_left -= sprite_get_xoffset(temp_sprite_index) * object_x_scale;
	temp_bbox_bottom -= sprite_get_yoffset(temp_sprite_index) * object_y_scale;
	temp_bbox_right -= sprite_get_xoffset(temp_sprite_index) * object_x_scale;
	temp_bbox_top -= sprite_get_yoffset(temp_sprite_index) * object_y_scale;
	
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