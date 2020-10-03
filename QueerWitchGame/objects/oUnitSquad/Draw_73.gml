/// @description Squad Unit Draw Event
// You can write your code in this editor

// Draw Unit Knockout (Perform Inherited Event);
event_inherited();

// Command Mode
if (canmove and player_input) {
	if (command or command_lerp_time) {
		// Draw Transparent Layer
		draw_set_alpha(0.4 * (1 - ((game_manager.time_spd - 0.2) / 0.8)));
		draw_set_color(make_color_rgb(50, 50, 50));
		draw_rectangle(game_manager.camera_x - 50, game_manager.camera_y - 50, game_manager.camera_x + game_manager.camera_width + 50, game_manager.camera_y + game_manager.camera_height + 50, false);
		draw_set_alpha(1);
		
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
		
		// Draw Unit Select Overlay
		if (!inventory_show and command) {
			// Draw Unit Outlines Overlay
			if (instance_exists(game_manager)) {
				if (surface_exists(game_manager.surface_manager.unit_outline_overlay_surface)) {
					draw_surface(game_manager.surface_manager.unit_outline_overlay_surface, game_manager.surface_manager.draw_x, game_manager.surface_manager.draw_y);
				}
			}
			
			// Draw Unit Select Cursor
			if (unit_select_hover != noone) {
				with (unit_select_hover) {
					var temp_health_show = health_show;
					health_show = false;
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
					health_show = temp_health_show;
				}
			}
			
			// Draw Squad Lines
			draw_set_color(squad_outline_color);
			for (var q = 0; q < instance_number(oUnitSquad); q++) {
				// Find Unit
				var temp_unit_squad_index = instance_find(oUnitSquad, q);
				with (temp_unit_squad_index) {
					// Check if Unit is Viables
					if (ai_behaviour) {
						if (ai_follow) {
							if (ai_follow_unit != noone) {
								if (instance_exists(ai_follow_unit)) {
									var temp_unit_squad_height = (hitbox_right_bottom_y_offset - hitbox_left_top_y_offset) / 2;
									var temp_unit_squad_follow_height = (ai_follow_unit.hitbox_right_bottom_y_offset - ai_follow_unit.hitbox_left_top_y_offset) / 2;
									draw_circle(ai_follow_unit.x, ai_follow_unit.y - temp_unit_squad_follow_height, 3, false);
									draw_line(x, y - temp_unit_squad_height, ai_follow_unit.x, ai_follow_unit.y - temp_unit_squad_follow_height);
								}
							}
						}
					}
				}
			}
			draw_set_color(c_white);
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