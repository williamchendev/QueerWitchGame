/// @description Editor Ribbon Object Draw
// Draws the Editor Ribbon to the screen

// Draw Set Font
draw_set_font(fHeartBit);

// Get Ribbon Propeties
var temp_ribbon_width = 0;
for (var i = 0; i < array_length_1d(ribbon_names); i++) {
	temp_ribbon_width += string_width(ribbon_names[i]);
	if (i < (array_length_1d(ribbon_names) - 1)) {
		temp_ribbon_width += ribbon_spacer;
	}
}

// Draw Ribbon
draw_set_color(c_black);
draw_rectangle(x, y, x + temp_ribbon_width + ribbon_spacer, y + ribbon_height, false);
draw_set_color(c_white);
draw_rectangle(x, y, x + temp_ribbon_width + ribbon_spacer, y + ribbon_height, true);

// Draw Ribbon Titles
var temp_ribbon_width = 0;
for (var i = 0; i < array_length_1d(ribbon_names); i++) {
	// Draw Title
	draw_text(x + (ribbon_spacer * (i + 0.5)) + temp_ribbon_width, y, ribbon_names[i]);
	temp_ribbon_width += string_width(ribbon_names[i]);
	
	// Draw Selection
	if (mouse_hover_index == i) {
		draw_set_color(c_white);
		var temp_button_start_x = (ribbon_spacer * (i + 0.5)) + (temp_ribbon_width - string_width(ribbon_names[i])) - ((ribbon_spacer / 2) + 1);
		var temp_button_end_x = (ribbon_spacer * (i + 0.5)) + temp_ribbon_width + ((ribbon_spacer / 2) - 1);
		draw_rectangle(clamp(x + temp_button_start_x, x, x + temp_button_start_x + 1), y + 1, x + temp_button_end_x, y + (ribbon_height - 1), false);
		draw_set_color(c_black);
		draw_text(x + (ribbon_spacer / 2) + (ribbon_spacer * i) + (temp_ribbon_width - string_width(ribbon_names[i])), y, ribbon_names[i]);
		draw_set_color(c_white);
	}
	
	// Draw Spacer
	if (i < (array_length_1d(ribbon_names) - 1)) {
		draw_text(x + (ribbon_spacer / 2) + (ribbon_spacer * (i + 0.4)) + temp_ribbon_width, y, "|");
	}
}

// Draw Drop Down Menu
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
		
		// Draw Box Behind
		var temp_ribbontext_width = 0;
		var temp_ribbontext_height = dropdown_spacer * (temp_ribbon_options_length + 0.5);
		for (var k = 0; k < mouse_hover_index; k++) {
			temp_ribbontext_width += string_width(ribbon_names[k]);
		}
		var temp_dropdown_x = (ribbon_spacer * mouse_hover_index) + temp_ribbontext_width;
		
		draw_set_color(c_black);
		draw_rectangle(x + temp_dropdown_x, y + ribbon_height, x + temp_dropdown_x + temp_largest_option_width + ribbon_spacer, y + ribbon_height + temp_ribbontext_height, false);
		draw_set_color(c_white);
		draw_rectangle(x + temp_dropdown_x, y + ribbon_height, x + temp_dropdown_x + temp_largest_option_width + ribbon_spacer, y + ribbon_height + temp_ribbontext_height, true);
		
		// Drop Down Options
		for (var q = 0; q < temp_ribbon_options_length; q++) {
			// Option Text
			var temp_option_valid = false;
			if (mouse_hover_index < array_height_2d(ribbon_actions)) {
				if (q < array_length_2d(ribbon_actions, mouse_hover_index)) {
					if (ribbon_actions[mouse_hover_index, q] != noone) {
						temp_option_valid = true;
						draw_text(x + temp_dropdown_x + (ribbon_spacer / 2), y + (dropdown_spacer * q) + ribbon_height, ribbon_options[mouse_hover_index, q]);
					}
				}
			}
			
			// Invalid Option Text
			if (!temp_option_valid) {
				draw_set_color(c_gray);
				draw_text(x + temp_dropdown_x + (ribbon_spacer / 2), y + (dropdown_spacer * q) + ribbon_height, ribbon_options[mouse_hover_index, q]);
				draw_set_color(c_white);
				continue;
			}
			
			// Selected Option Text
			if (dd_mouse_hover_index == q) {
				var temp_optionbox_x = x + temp_dropdown_x + (ribbon_spacer / 2);
				var temp_optionbox_y = y + (dropdown_spacer * (q + 0.5)) + ribbon_height;
				draw_set_color(c_white);
				draw_rectangle(temp_optionbox_x - 1, temp_optionbox_y - 1, temp_optionbox_x + string_width(ribbon_options[mouse_hover_index, q]), temp_optionbox_y + 7, false);
				draw_set_color(c_black);
				draw_text(x + temp_dropdown_x + (ribbon_spacer / 2), y + (dropdown_spacer * q) + ribbon_height, ribbon_options[mouse_hover_index, q]);
				draw_set_color(c_white);
			}
		}
	}
}