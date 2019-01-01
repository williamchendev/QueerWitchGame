/// @description Draw Unit GUI Event
// draws the unit's gui to the screen

// Draw Unit GUI
if (menu_alpha > 0.05) {
	// Draw GUI Menu Select Options
	draw_set_color(c_black);
	for (var i = 0; i < 5; i++) {
		var selected_option = ((4 - i) == menu_radial_select);
		draw_set_alpha(menu_radial_node[i, 2] * (menu_alpha * menu_alpha));
		draw_circle(menu_radial_node[i, 0], y + slope_offset - ((menu_alpha * 16) + 48), 8 * menu_radial_node[i, 1], selected_option);
	}
	
	// Draw GUI Menu selected option text
	if (gui_mode == "select") {
		
		var temp_radial_text = "Actions";
		if (menu_radial_select == 1) {
			var temp_radial_text = "Magic";
		}
		else if (menu_radial_select == 2) {
			var temp_radial_text = "Inventory";
		}
		else if (menu_radial_select == 3) {
			var temp_radial_text = "Comrades";
		}
		else if (menu_radial_select == 4) {
			var temp_radial_text = "Settings";
		}
		draw_set_alpha(menu_alpha * menu_alpha * menu_alpha);
		draw_set_font(fHeartBit);
		draw_set_halign(fa_center);
		drawTextOutline(x + lengthdir_y(48, slope_angle), y + slope_offset - (((menu_alpha * menu_alpha) * 16) + 74), c_white, c_black, temp_radial_text);
	}
}

// Reset Drawing Values
draw_set_halign(fa_left);
draw_set_font(-1);
draw_set_color(c_white);
draw_set_alpha(1);