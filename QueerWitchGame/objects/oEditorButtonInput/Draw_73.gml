/// @description Editor Button Input Draw
// Draws the button to the screen

// Set Text Settings
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fNormalFont);

// Draw the button
if (press) {
	draw_set_color(c_black);
	draw_rectangle(x, y, x + width, y + height, false);
	draw_set_color(c_white);
	draw_rectangle(x, y, x + width, y + height, true);
	draw_rectangle(x + 2, y + 2, x + width - 2, y + height - 2, true);
	drawTextOutline(x + (width / 2), y + (height / 2) + y_offset, c_black, c_white, button_name);
}
else {
	draw_set_color(c_white);
	draw_rectangle(x, y, x + width, y + height, false);
	if (hover) {
		draw_rectangle(x - 2, y - 2, x + width + 2, y + height + 2, true);
	}
	drawTextOutline(x + (width / 2), y + (height / 2) + y_offset, c_white, c_black, button_name);
}

// Reset Variables
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);