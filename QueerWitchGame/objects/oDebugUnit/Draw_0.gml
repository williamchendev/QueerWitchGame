/// @description Draw Unit Event
// draws the unit and unit GUI to the screen

// Draw Unit Sprite
draw_sprite_ext(sprite_index, image_index, x, y + slope_offset, draw_xscale * image_xscale, draw_yscale, slope_angle, image_blend, image_alpha);

// Draw Unit GUI
if (menu_alpha > 0.05) {
	draw_set_color(c_black);
	for (var i = 0; i < 5; i++) {
		var selected_option = ((4 - i) == menu_radial_select);
		draw_set_alpha(menu_radial_node[i, 2] * (menu_alpha * menu_alpha));
		draw_circle(menu_radial_node[i, 0], y + slope_offset - ((menu_alpha * 16) + 48), 8 * menu_radial_node[i, 1], selected_option);
	}
}
draw_set_color(c_white);
draw_set_alpha(1);