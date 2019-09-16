/// @description Editor Ribbon Object Step
// Initializes the variables of the Editor Ribbon

// Update Position
y = oGameManager.camera_y - 1;
if (instance_exists(oEditorObjectSelectMenu)) {
	var temp_x_offset = 9;
	if (oEditorObjectSelectMenu.expanded) {
		temp_x_offset = 117;
	}
	x = oGameManager.camera_x + temp_x_offset;
}
else {
	x = oGameManager.camera_x;
}

// Cease Behaviour if Editor Window Exists
if (instance_exists(oEditorWindow)) {
	return;
}

// Set Font
draw_set_font(fHeartBit);

// Drop Down Calculations
if (mouse_hover_index != -1) {
	// Check if Drop Down Menu is Valid
	if (mouse_hover_index < array_height_2d(ribbon_options)) {
		// Drop Down Settings
		var temp_ribbon_options_length = array_length_2d(ribbon_options, mouse_hover_index);
		var temp_largest_option_width = 0;
		for (var i = 0; i < temp_ribbon_options_length; i++) {
			var temp_option = ribbon_options[mouse_hover_index, i];
			if (string_width(temp_option) > temp_largest_option_width) {
				temp_largest_option_width = string_width(temp_option);
			}
		}
		
		var temp_ribbontext_width = 0;
		var temp_ribbontext_height = dropdown_spacer * (temp_ribbon_options_length + 0.5);
		for (var k = 0; k < mouse_hover_index; k++) {
			temp_ribbontext_width += string_width(ribbon_names[k]);
		}
		var temp_dropdown_x = (ribbon_spacer * mouse_hover_index) + temp_ribbontext_width;
		
		// Check if mouse is over Drop Down Menu
		var temp_dropdown_hover = false;
		if ((mouse_room_x() > (x + temp_dropdown_x)) and (mouse_room_x() < (x + temp_dropdown_x + temp_largest_option_width + ribbon_spacer))) {
			if ((mouse_room_y() > (y + ribbon_height - 4)) and (mouse_room_y() < (y + ribbon_height + temp_ribbontext_height))) {
				temp_dropdown_hover = true;
			}
		}
		
		// Drop Down Behaviour
		if (temp_dropdown_hover) {
			// Reset Drop Down Index
			dd_mouse_hover_index = -1;
			
			// Iterate through Drop Down Options
			for (var q = 0; q < temp_ribbon_options_length; q++) {
				var temp_option = ribbon_options[mouse_hover_index, q];
				if ((mouse_room_x() > (x + temp_dropdown_x + (ribbon_spacer / 2) - 1)) and (mouse_room_x() < (x + temp_dropdown_x + (ribbon_spacer / 2) + string_width(temp_option)))) {
					var temp_option_y = y + (dropdown_spacer * (q + 0.5)) + ribbon_height;
					if ((mouse_room_y() > temp_option_y - 1) and (mouse_room_y() < temp_option_y + 7)) {
						dd_mouse_hover_index = q;
						break;
					}
				}
			}
			
			// Drop Down Option Behaviour
			if (dd_mouse_hover_index != -1) {
				if (mouse_check_button_pressed(mb_left)) {
					// Drop Down Option Window
					var temp_option_pressed = false;
					if (mouse_hover_index < array_height_2d(ribbon_actions)) {
						if (dd_mouse_hover_index < array_length_2d(ribbon_actions, mouse_hover_index)) {
							if (ribbon_actions[mouse_hover_index, dd_mouse_hover_index] != noone) {
								temp_option_pressed = true;
								if (is_string(ribbon_actions[mouse_hover_index, dd_mouse_hover_index])) {
									print_editor_error(ribbon_actions[mouse_hover_index, dd_mouse_hover_index], "Info");
								}
								else {
									instance_create_layer(x, y, layer_get_id("Editor_UI"), ribbon_actions[mouse_hover_index, dd_mouse_hover_index]);
								}
							}
						}
					}
					
					// Title Hover Reset
					if (temp_option_pressed) {
						if (oEditor.editor_click) {
							mouse_hover_index = -1;
							ribbon_menu_selected = false;
							oEditor.editor_click = false;
						}
					}
				}
			}
		}
		else {
			// Reset Title from Ribbon Selected
			if (ribbon_menu_selected) {
				if (mouse_check_button_pressed(mb_left)) {
					// Title Hover Reset
					mouse_hover_index = -1;
					ribbon_menu_selected = false;
					oEditor.editor_click = false;
				}
			}
			else {
				// Title Hover Reset
				mouse_hover_index = -1;
			}
		}
	}
}

// Ribbon Title Calculations
if (!ribbon_menu_selected) {
	// Check Title Hover and Selection
	if (abs((y + (ribbon_height / 2)) - mouse_room_y()) < (ribbon_height / 2)) {
		// Iterate through all titles
		var temp_ribbon_width = ribbon_spacer / 2;
		for (var i = 0; i < array_length_1d(ribbon_names); i++) {
			// Get Ribbon Button X Bounds
			var temp_button_start_x = temp_ribbon_width - ((ribbon_spacer / 2) - 1);
			temp_ribbon_width += string_width(ribbon_names[i]);
			var temp_button_end_x = temp_ribbon_width + ((ribbon_spacer / 2) - 1);
	
			// Check if Mouse Hover
			if (mouse_room_x() > (x + temp_button_start_x)) {
				if (mouse_room_x() < (x + temp_button_end_x)) {
					mouse_hover_index = i;
					break;
				}
			}
	
			// Add Spacer
			temp_ribbon_width += ribbon_spacer;
		}
		
		// Title Click Behaviour
		if (mouse_hover_index != -1) {
			if (mouse_check_button_pressed(mb_left)) {
				if (mouse_hover_index < array_height_2d(ribbon_options)) {
					if (oEditor.editor_click) {
						ribbon_menu_selected = true;
						oEditor.editor_click = false;
					}
				}
			}
		}
	}
}