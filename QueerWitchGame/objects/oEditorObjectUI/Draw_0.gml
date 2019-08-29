/// @description Editor Object Draw End
// Draws the Editor Object UI

// Draw Object UI
x = editor_object.x;
y = editor_object.y;

// Check if Object is Valid
if (editor_object.object_editor_id != -1) {
	// Draw Selected Behaviour
	if (editor_object.selected) {
		// Draw Selected Box
		if (editor_object.edges_calc) {
			// Draw Edges
			draw_sprite_ext(sEditorSelect, 0, x + editor_object.edge_a, y + editor_object.edge_c, 1, 1, 0, c_white, 1);
			draw_sprite_ext(sEditorSelect, 0, x + editor_object.edge_a, y + editor_object.edge_d, 1, -1, 0, c_white, 1);
			draw_sprite_ext(sEditorSelect, 0, x + editor_object.edge_b, y + editor_object.edge_d, -1, -1, 0, c_white, 1);
			draw_sprite_ext(sEditorSelect, 0, x + editor_object.edge_b, y + editor_object.edge_c, -1, 1, 0, c_white, 1);
		
			// Draw Mids
			draw_sprite(sEditorSelect, 1, x + editor_object.edge_a, y + editor_object.mid_b);
			draw_sprite(sEditorSelect, 1, x + editor_object.edge_b - 1, y + editor_object.mid_b);
			draw_sprite(sEditorSelect, 2, x + editor_object.mid_a, y + editor_object.edge_c);
			draw_sprite(sEditorSelect, 2, x + editor_object.mid_a, y + editor_object.edge_d - 1);
			
			/*
			// Detailed Draw Mids
			var temp_mid_width = editor_object.edge_b - editor_object.edge_a;
			var temp_mid_height = editor_object.edge_d - editor_object.edge_c;
			
			var temp_mid_width_limit = (temp_mid_width / 2) div 10;
			for (var w = 0; w < temp_mid_width_limit; w++) {
				var temp_spacer = (temp_mid_width / 2) / temp_mid_width_limit;
				draw_sprite(sEditorSelect, 2, x + editor_object.mid_a + (w * temp_spacer), y + editor_object.edge_c);
				draw_sprite(sEditorSelect, 2, x + editor_object.mid_a + (w * temp_spacer), y + editor_object.edge_d - 1);
				draw_sprite(sEditorSelect, 2, x + editor_object.mid_a - (w * temp_spacer), y + editor_object.edge_c);
				draw_sprite(sEditorSelect, 2, x + editor_object.mid_a - (w * temp_spacer), y + editor_object.edge_d - 1);
			}
			
			var temp_mid_height_limit = (temp_mid_height / 2) div 10;
			for (var h = 0; h < temp_mid_height_limit; h++) {
				var temp_spacer = (temp_mid_height / 2) / temp_mid_height_limit;
				draw_sprite(sEditorSelect, 1, x + editor_object.edge_a, y + editor_object.mid_b + (h * temp_spacer));
				draw_sprite(sEditorSelect, 1, x + editor_object.edge_b - 1, y + editor_object.mid_b + (h * temp_spacer));
				draw_sprite(sEditorSelect, 1, x + editor_object.edge_a, y + editor_object.mid_b - (h * temp_spacer));
				draw_sprite(sEditorSelect, 1, x + editor_object.edge_b - 1, y + editor_object.mid_b - (h * temp_spacer));
			}
			*/
			
			// Set Detail Offset
			var temp_bbox_top = editor_object.edge_c - 3;
			var temp_bbox_right = editor_object.edge_b + 3;
			
			// Draw Details of the Object
			draw_set_font(fHeartBit);
			if (editor_object.object_show_details) {
				// Find Object Details
				var temp_detail_id = "ID: " + string(editor_object.object_editor_id);
				var temp_detail_type = "Type: " + editor_object.object_type;
				var temp_detail_name = "Name: \"" + object_get_name(global.editor_data[editor_object.object_editor_id, 0]) + "\"";
				var temp_detail_pos = "[X = " + string(round(x)) + ", Y = " + string(round(y)) + "]";
		
				// Draw Details
				drawTextOutline(x + temp_bbox_right, y + temp_bbox_top, c_white, c_black, temp_detail_id);
				drawTextOutline(x + temp_bbox_right, y + temp_bbox_top + 9, c_white, c_black, temp_detail_type);
				drawTextOutline(x + temp_bbox_right, y + temp_bbox_top + 18, c_white, c_black, temp_detail_name);
				drawTextOutline(x + temp_bbox_right, y + temp_bbox_top + 27, c_white, c_black, temp_detail_pos);
			}
			else {
				drawTextOutline(x + temp_bbox_right, y + temp_bbox_top, c_white, c_black, object_get_name(global.editor_data[editor_object.object_editor_id, 0]));
				if (editor_object.mouse_press) {
					if (editor_object.mouse_mode == 0) {
						var temp_draw_angle = editor_object.object_rotation;
						if (editor_object.object_rotation > 360) {
							temp_draw_angle = editor_object.object_rotation mod 360;
						}
						else if (editor_object.object_rotation < 0) {
							temp_draw_angle = 360 + (editor_object.object_rotation mod 360);
						}
						drawTextOutline(x + temp_bbox_right, y + temp_bbox_top + 9, c_white, c_black, "Angle: " + string(temp_draw_angle) + "°");
					}
					else if (editor_object.mouse_mode == 3) {
						drawTextOutline(x + temp_bbox_right, y + temp_bbox_top + 9, c_white, c_black, "[X = " + string(round(x)) + ", Y = " + string(round(y)) + "]");
					}
				}
			}
	
			// Reset Draw
			draw_set_color(c_white);
		}
	}
}