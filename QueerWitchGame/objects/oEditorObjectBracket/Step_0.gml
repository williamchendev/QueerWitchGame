/// @description Editor Object Sub-Menu Update
// Calculates the behaviour of the sub menu in the editor

// Check if the main object menu set this bracket as active
if (visible) {
	// Check if the user clicked to expand or shrink this submenu
	if (mouse_check_button_pressed(mb_left) and oEditor.editor_click) {
		if (abs(mouse_room_x() - (x + 53.5)) < 52) {
			if (abs(mouse_room_y() - (y + 8.5)) < 8) {
				// Pull in or push out sub menu
				expanded = !expanded;
				oEditor.editor_click = false;
			}
		}
	}

	// Check if User mouse is hovering over an option and display the selected option as hovering text
	var temp_hover_text = hover_text;
	hover_text = noone;
	for (var i = 0; i < array_length_1d(options); i++) {
		var temp_x_pos = i mod 3;
		var temp_y_pos = floor(i / 3);
		options[i].x = x + 18 + (temp_x_pos * 36);
		options[i].y = y + 31 + (temp_y_pos * 36);
		if (options[i].hover) {
			hover_text = options[i].button_name;
			if (entity_type != 1) {
				hover_text_details = global.editor_data[(entity_type * global.editor_data_categories_length) + i, 2];
			}
		}
		if (options[i].selected) {
			selected = i;
		}
		options[i].visible = expanded;
	}
	
	if (temp_hover_text == hover_text) {
		if (hover_text_details == "") {
			hover_text_details_timer = 60;
		}
		
		if (hover_text_details_timer > 0) {
			hover_text_details_timer--;
		}
	}
	else {
		hover_text_details_timer = 60;
	}
}