/// @description Draw Unit GUI Event
// draws the unit's gui to the screen

// Draw Unit Actions & Magic Select Menu
if (select_alpha > 0.05) {
	// Unit Select Menu Position Variables
	var temp_select_x = x + select_menu_x_offset - (32 * (1 - select_alpha));
	var temp_select_y = y + select_menu_y_offset;
	
	// Unit Draw Select Menu
	draw_set_alpha(select_alpha * select_alpha);
	
	// Draw Selection List
	if (gui_mode = "actions") {
		// Draw Actions List
		for (var i = 0; i < select_list_length; i++) {
			// Calculate Radial Position of Action Option
			var temp_action_sin = (i - select_menu_draw_pos) * -15;
			var temp_action_x = temp_select_x + lengthdir_x(100, temp_action_sin) - 70;
			var temp_action_y = temp_select_y + lengthdir_y(80, temp_action_sin);
				
			var draw_sin = (sin((sin_val - (i * 0.12)) * 2 * pi) / 2) + 1;
				
			// Temporary Variables for Action Item Type and Action Item ID
			if (select_list != noone) {
				var temp_item_type = global.item_data[select_list[i], itemstats.type];
				var temp_item_type_index = global.item_data[select_list[i], itemstats.type_index];
			}
			else {
				var temp_item_type = -1;
				var temp_item_type_index = 0;
			}
				
			// Draw Action Option
			if (i == select_menu_select) {
				// Action Option Image Index and Text
				var temp_action_text = "";
				var temp_action_image_index = 0;
				if (temp_item_type = itemtypes.consumable) {
					// Action Option Title from Consumable item data
					var temp_item_stack_text = "";
					if (select_item_stacks > 1) {
						temp_item_stack_text = " (x" + string(select_item_stacks) + ")";
					}
					temp_action_text = global.consumable_data[temp_item_type_index, consumablestats.action_title] + temp_item_stack_text;
					temp_action_image_index = global.consumable_data[temp_item_type_index, consumablestats.image_index];
				}
				else if (temp_item_type = itemtypes.weapon) {
					// Action Option Title from Consumable item data
					var temp_item_stack_text = "";
					if (select_item_stacks > 1) {
						temp_item_stack_text = " (x" + string(select_item_stacks) + ")";
					}
					temp_action_text = global.weapon_data[temp_item_type_index, weaponstats.action_title] + temp_item_stack_text;
					temp_action_image_index = global.weapon_data[temp_item_type_index, weaponstats.image_index];
				}
				else if (temp_item_type = -1) {
					var temp_action_text = "Inventory empty";
				}
					
				// Set Action Option draw settings
				draw_set_font(fHeartBit);
				draw_set_alpha(select_alpha * select_alpha);
					
				// Draw selected blip
				draw_set_color(c_black);
				var temp_action_offset = (draw_sin * 3) + 6;
				var temp_action_bar_length = string_width(temp_action_text) * clamp(select_option_lerp + 0.05, 0, 1);
				var temp_action_bar_text = format_string_width_single_line(temp_action_text, round(temp_action_bar_length));
				draw_roundrect(temp_action_x - temp_action_offset, temp_action_y - temp_action_offset, temp_action_x + temp_action_offset + temp_action_bar_length + 8, temp_action_y + temp_action_offset, false);
					
				// Draw selected blip outline
				draw_set_color(c_white);
				draw_roundrect(temp_action_x - temp_action_offset, temp_action_y - temp_action_offset, temp_action_x + temp_action_offset + temp_action_bar_length + 8, temp_action_y + temp_action_offset, true);
					
				// Set can use alpha
				if (!select_can_use) {
					draw_line(temp_action_x + 8, temp_action_y + 2, temp_action_x + temp_action_bar_length + 10, temp_action_y + 2);
					draw_set_alpha(select_alpha * select_alpha * 0.6);
				}
					
				// Draw selected sprite
				draw_sprite(sUI_Action, temp_action_image_index, temp_action_x, temp_action_y);
					
				// Draw selected text
				draw_set_halign(fa_left);
				draw_set_valign(fa_center);
				draw_text(temp_action_x + 10, temp_action_y - 1, temp_action_bar_text);
					
				draw_set_valign(fa_top);
			}
			else {
				// Draw non selected blip
				var temp_action_alpha = clamp((1.5 - abs(select_menu_draw_pos - i)) / 1.5, 0, 1);
				//var temp_action_alpha = 0.4;
				draw_set_alpha(select_alpha * select_alpha * temp_action_alpha);
					
				draw_set_color(c_black);
				draw_circle(temp_action_x, temp_action_y, (draw_sin * 2) + 6, false);
					
				draw_set_color(c_white);
				draw_circle(temp_action_x, temp_action_y, (draw_sin * 2) + 6, true);
					
				if (temp_item_type = itemtypes.consumable) {
					draw_sprite(sUI_Action, global.consumable_data[temp_item_type_index, consumablestats.image_index], temp_action_x, temp_action_y);
				}
				else if (temp_item_type = itemtypes.weapon) {
					draw_sprite(sUI_Action, global.weapon_data[temp_item_type_index, weaponstats.image_index], temp_action_x, temp_action_y);
				}
			}
		}
	}
	
	/// *** DEBUG ***
	/*
	draw_set_font(-1);
	draw_set_color(c_black);
	draw_set_alpha(select_alpha * select_alpha);
	if (select_list != noone) {
		for (var i = 0; i < array_length_1d(select_list); i++) {
			var temp_item_type = global.item_data[select_list[i], itemstats.type];
			var temp_item_type_index = global.item_data[select_list[i], itemstats.type_index];
			
			if (temp_item_type = itemtypes.consumable) {
				var temp_consumable_title = global.consumable_data[temp_item_type_index, consumablestats.action_title];
				draw_text(x - 220, y + (16 * i) - 160, temp_consumable_title);
			}
		}
	}
	*/
}

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
		drawTextOutline(x + lengthdir_y(48, slope_angle), y + slope_offset - (((menu_alpha * menu_alpha) * 16) + 74), c_white, c_black, temp_radial_text);
	}
}

// Draw Unit Stats GUI
if (draw_stats_mode == "health") {
	// Unit Stat position variables
	var temp_stats_x = x + lengthdir_y(48, slope_angle) + ui_stat_x_offset;
	var temp_stats_y = bbox_top + ui_stat_y_offset + slope_offset + (32 * (1 - draw_stats_alpha));
	
	// Draw Health Blips
	var temp_health_pos_x = temp_stats_x - ((max_health_points * 0.5) * 8) - 1 + (8 * health_points);
	draw_set_alpha(draw_stats_alpha * draw_stats_alpha);
	for (var i = health_points; i < max_health_points; i++) {
		draw_sprite(sUI_Health, 1, temp_health_pos_x, temp_stats_y - 27);
		
		if (select_consumable_strength > 0) {
			if (i - health_points < select_consumable_strength) {
				var draw_sin = (sin((sin_val + 0.23) * 2 * pi) / 2) + 1;
				draw_set_alpha(draw_stats_alpha * draw_stats_alpha * ((draw_sin * 0.2) + 0.2));
				draw_sprite(sUI_Health, 2, temp_health_pos_x, temp_stats_y - 27);
				
				draw_set_alpha(draw_stats_alpha * draw_stats_alpha);
			}
		}
		
		temp_health_pos_x += 8;
	}
	
	var temp_health_pos_x = temp_stats_x - ((max_health_points * 0.5) * 8) - 1;
	for (var i = 0; i < health_points; i++) {
		draw_sprite(sUI_Health, 0, temp_health_pos_x, temp_stats_y - 27);
		temp_health_pos_x += 8;
	}
	
	// Draw Health Count Text
	draw_set_font(fDiest64);
	draw_set_halign(fa_center);
	
	draw_set_alpha(0.8 * draw_stats_alpha * draw_stats_alpha);
	draw_set_color(c_black);
	draw_text(temp_stats_x + 1, temp_stats_y - 16, string(health_points) + " Health");
	
	draw_set_alpha(draw_stats_alpha * draw_stats_alpha);
	draw_set_color(c_white);
	draw_text(temp_stats_x, temp_stats_y - 17, string(health_points) + " Health");
}
else if (draw_stats_mode == "calories") {
	// Unit Stat position variables
	var temp_stats_x = x + lengthdir_y(48, slope_angle) + ui_stat_x_offset;
	var temp_stats_y = bbox_top + ui_stat_y_offset + slope_offset + (32 * (1 - draw_stats_alpha));
	
	// Draw Calorie Meter
	var temp_calorie_width = round((max_calories - 1000) * 0.002) + 32;
	var temp_calorie_percent_width = temp_calorie_width * (calorie_show / max_calories);
	temp_calorie_width *= 0.5;
	
	draw_set_alpha(draw_stats_alpha * draw_stats_alpha * 0.4);
	
	// Draw Back of Calorie Meter
	draw_set_color(calorie_color_4);
	draw_rectangle(temp_stats_x - temp_calorie_width - 1, temp_stats_y - 22, temp_stats_x + temp_calorie_width - 1, temp_stats_y - 19, false);
	
	// Draw Calorie Meter Refill
	if (select_consumable_strength > 0) {
		var draw_sin = (sin((sin_val + 0.23) * 2 * pi) / 2) + 1;
		
		draw_set_color(c_white);
		draw_set_alpha(draw_stats_alpha * draw_stats_alpha * ((draw_sin * 0.1) + 0.4));
		var temp_calorie_refill_width = round((temp_calorie_width * 2) * (clamp(calorie_show + select_consumable_strength, 0, max_calories) / max_calories));
		
		draw_rectangle(temp_stats_x - temp_calorie_width - 1, temp_stats_y - 22, (temp_stats_x - temp_calorie_width) + temp_calorie_refill_width - 1, temp_stats_y - 19, false);
	}
	
	// Draw Front of Calorie Meter
	draw_set_alpha(draw_stats_alpha * draw_stats_alpha);
	
	draw_set_color(calorie_color_2);
	draw_rectangle(temp_stats_x - temp_calorie_width - 1, temp_stats_y - 22, (temp_stats_x - temp_calorie_width) + temp_calorie_percent_width - 1, temp_stats_y - 19, false);
	
	draw_set_color(calorie_color_1);
	draw_rectangle(temp_stats_x - temp_calorie_width - 1, temp_stats_y - 20, (temp_stats_x - temp_calorie_width) + temp_calorie_percent_width - 1, temp_stats_y - 19, false);
	
	draw_set_color(calorie_color_3);
	draw_rectangle(temp_stats_x - temp_calorie_width - 1, temp_stats_y - 21, (temp_stats_x - temp_calorie_width) + temp_calorie_percent_width - 1, temp_stats_y - 20, false);
	
	// Draw Calorie Count Text
	draw_set_font(fDiest64);
	draw_set_halign(fa_center);
	
	draw_set_alpha(0.8 * draw_stats_alpha * draw_stats_alpha);
	draw_set_color(c_black);
	draw_text(temp_stats_x + 1, temp_stats_y - 16, format_str_int_comma(round(calorie_show)) + " kcal");
	
	draw_set_alpha(draw_stats_alpha * draw_stats_alpha);
	draw_set_color(c_white);
	draw_text(temp_stats_x, temp_stats_y - 17, format_str_int_comma(round(calorie_show)) + " kcal");
}

// Reset Drawing Values
draw_set_halign(fa_left);
draw_set_font(-1);
draw_set_color(c_white);
draw_set_alpha(1);