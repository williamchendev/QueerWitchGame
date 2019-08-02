/// @description Editor Text Input Draw
// Draws the text input to the screen

// Draw Settings
draw_set_font(font);

// Draw Box
draw_set_color(c_black);
draw_rectangle(x, y, x + width, y + height, false);
draw_set_color(c_white);
draw_rectangle(x, y, x + width, y + height, true);

// Draw Text
if (string_length(text_input) <= 0) {
	if (empty_text != noone) {
		draw_set_alpha(0.6);
		draw_text(x + 3, y - 1, empty_text);
		draw_set_alpha(1);
	}
}
else {
	draw_text(x + 3, y - 1, text_display);
}

// Draw Selection
if (selected) {
	if (line_timer < 25) {
		var text_width = string_width(string_copy(text_input, text_show + 1, select_index - text_show));
		draw_line(x + 3 + text_width, y + 1, x + 3 + text_width, y + 11);
	}
}