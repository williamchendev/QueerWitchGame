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