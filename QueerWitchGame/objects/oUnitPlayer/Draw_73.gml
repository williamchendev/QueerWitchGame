/// @description Insert description here
// You can write your code in this editor

// Draw Unit Knockout (Perform Inherited Event);
event_inherited();

// Command Mode
if (canmove) {
	if (command or command_lerp_time) {
		// Draw Transparent Layer
		draw_set_alpha(0.4 * (1 - ((game_manager.time_spd - 0.2) / 0.8)));
		draw_set_color(make_color_rgb(50, 50, 50));
		draw_rectangle(game_manager.camera_x - 50, game_manager.camera_y - 50, game_manager.camera_x + game_manager.camera_width + 50, game_manager.camera_y + game_manager.camera_height + 50, false);
	
		// Draw Character Overlay
		for (var l = 0; l < array_length_1d(layers); l++) {
			// Find Layer Elements
			var temp_layer_elements = layer_get_all_elements(layers[l]);
			for (var i = 0; i < array_length_1d(temp_layer_elements); i++) {
				// Check if Element is an Instance
			    if (layer_get_element_type(temp_layer_elements[i]) == layerelementtype_instance) {
					// Draw Instance
				    var temp_inst = layer_instance_get_instance(temp_layer_elements[i]);
				    with (temp_inst) {
						event_perform(ev_draw, 0);
					}
			    }
			}
		}
	}
}

/*
// Draw Unit Menu GUI
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
		drawTextOutline(x, y - (((menu_alpha * menu_alpha) * 16) + 74), c_white, c_black, temp_radial_text);
	}
}
*/