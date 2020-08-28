/// @description Debug Node Draw Event
// Draws Debug info on the Node Object

if (!global.debug) {
	return;
}

draw_set_color(c_purple);
draw_line(x, y, x_position, y_position);
draw_circle(x_position, y_position, 3, false);
draw_set_color(c_white);

draw_circle(x, y, 5, false);