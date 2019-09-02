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

// Ribbon Title Calculations
draw_set_font(fHeartBit);
if (!ribbon_menu_selected) {
	// Title Hover Reset
	mouse_hover_index = -1;
	
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
				ribbon_menu_selected = true;
			}
		}
	}
}
else {
	
}