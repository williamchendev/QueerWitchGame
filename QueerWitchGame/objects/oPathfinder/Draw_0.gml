/// @description Insert description here
// You can write your code in this editor

if (global.debug) {
	if (path != noone) {
		draw_set_color(c_red);
		for (var i = 0; i < array_length_1d(path); i++) {
			draw_circle(path[i].x, path[i].y, 2, false);
		}
		for (var i = 0; i < array_length_1d(path) - 1; i++) {
			draw_line(path[i].x, path[i].y, path[i + 1].x, path[i + 1].y);
		}
		draw_set_color(c_blue);
		draw_circle(path[0].x, path[0].y, 2, false);
		draw_set_color(c_white);
	}
}