/// @description Editor Object Sub-Menu Draw
// Draws the Bracket to the screen along with the bracket name and the hover text

// Set the font
draw_set_font(fHeartBit);

// Draw the bottom bracket seperators
draw_rectangle(x, y, x + 107, y + 10, false);
if (expanded) {
	draw_rectangle(x, y + height + 15, x + 107, y + height + 17, false);
}
else {
	draw_rectangle(x, y + 15, x + 107, y + 17, false);
}

// Draw the name of the bracket
drawTextOutline(x + 3, y - 3, c_white, c_black, bar_name);

// Draw the hover text
if (hover_text != noone) {
	draw_set_font(fHeartBit);
	drawTextOutline(mouse_room_x() + 6, mouse_room_y() - 16, c_white, c_black, hover_text);
}