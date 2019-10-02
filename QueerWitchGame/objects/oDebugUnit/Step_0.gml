/// @description Unit Update Event
// performs calculations necessary for the Unit's behavior

// Key Checks (Player Input)
var key_left = false;
var key_right = false;
var key_up = false;
var key_down = false;

var key_left_press = false;
var key_right_press = false;
var key_up_press = false;
var key_down_press = false;

var key_select_press = false;
var key_cancel_press = false;
var key_menu_press = false;

if (player_input) {
	if (game_manager != noone) {
		key_left = keyboard_check(game_manager.left_check);
		key_right = keyboard_check(game_manager.right_check);
		key_up = keyboard_check(game_manager.up_check);
		key_down = keyboard_check(game_manager.down_check);

		key_left_press = keyboard_check_pressed(game_manager.left_check);
		key_right_press = keyboard_check_pressed(game_manager.right_check);
		key_up_press = keyboard_check_pressed(game_manager.up_check);
		key_down_press = keyboard_check_pressed(game_manager.down_check);
		
		key_select_press = keyboard_check_pressed(game_manager.select_check);
		key_cancel_press = keyboard_check_pressed(game_manager.cancel_check);
		key_menu_press = keyboard_check_pressed(game_manager.menu_check);
	}
}

// Movement (Player Input)
if (canmove and !game_manager.stop_time) {
	// Action Refill
	action += action_spd;
	action = clamp(action, 0, 1);
	
	//**DEBUG CODE TARGETING ATTACK**
	if (action >= 1) {
		if (targets != noone) {
			if (instance_exists(targets[target])) {
				targets[target].hp--;
				action = 0;
			}
		}
	}
	
	// Move player left and right
	if (key_left) {
		x_velocity = -spd;
	}
	else if (key_right) {
		x_velocity = spd;
	}
	else {
		x_velocity = 0;
	}
	
	// Jumping
	if (key_up) {
		if (!platform_free(x, y + 1, platform_list)) {
			// First Jump
			y_velocity = 0;
			y_velocity -= jump_spd;
			jump_velocity = jump_hold_spd;
			double_jump = true;
			
			// Squash and Stretch
			draw_xscale = 1 - squash_stretch;
			draw_yscale = 1 + squash_stretch;
		}
		else if (key_up_press) {
			// Double Jump
			if (double_jump) {
				y_velocity = 0;
				y_velocity -= jump_double_spd;
				jump_velocity = jump_hold_spd;
				double_jump = false;
				
				// Squash and Stretch
				draw_xscale = 1 - squash_stretch;
				draw_yscale = 1 + squash_stretch;
			}
		}
		else if (y_velocity < 0) {
			// Variable Jump Height
			y_velocity -= jump_velocity;
			jump_velocity *= jump_decay;
		}
	}
	
	// Jumping Down (Platforms)
	if (key_down_press) {
		if (place_free(x, y + 1) and !platform_free(x, y + 1, platform_list)) {
			y += 1;
			y_velocity += 0.05;
		}
	}
	
	// Switch to player menu
	menu_alpha = lerp(menu_alpha, 0, menu_lerp_spd);
	select_alpha = lerp(select_alpha, 0, menu_lerp_spd);
	if (key_menu_press) {
		canmove = false;
		gui_mode = "select";
		menu_radial_draw_pos = menu_radial_select;
		menu_radial_target_pos = menu_radial_select;
		game_manager.stop_time = true;
		
		// ****DEBUG****
		// Debug Sparkle Effect (Remove in the future)
		//instance_create_depth(x, y, depth - 1, oSparkleEffect1);
		
		x_velocity = 0;
	}
}
else {
	// GUI Menu modes
	if (gui_mode == "select") {
		// Move through select options in menu
		if (key_left_press) {
			menu_radial_select--;
			menu_radial_target_pos--;
			if (menu_radial_select < 0) {
				menu_radial_select = 4;
			}
		}
		else if (key_right_press) {
			menu_radial_select++;
			menu_radial_target_pos++;
			if (menu_radial_select > 4) {
				menu_radial_select = 0;
			}
		}
		
		// Select Menu option
		if (key_select_press) {
			if (menu_radial_select == 0) {
				// Select Action Option
				gui_mode = "actions";
				
				// Prepare Select Menu with Action Options
				select_list = createActionList(self);
				select_list_length = 1;
				select_menu_select = 0;
				if (select_list != noone) {
					select_list_length = array_length_1d(select_list);
					select_menu_select = select_list_length div 2;
				}
				
				select_menu_draw_pos = select_menu_select;
				select_option_lerp = 0;
				select_update_option = true;
			}
			else if (menu_radial_select == 2) {
				// Select Inventory Option
				gui_mode = "inventory";
			}
		}
	
		// Lerp radial menu
		menu_alpha = lerp(menu_alpha, 1, menu_lerp_spd);
		menu_radial_draw_pos = lerp(menu_radial_draw_pos, menu_radial_target_pos, menu_lerp_spd);
		
		// Lerp select menu
		select_alpha = lerp(select_alpha, 0, menu_lerp_spd);
	}
	else {
		// UI Navigation
		if (gui_mode == "actions") {
			// Action Management
			var temp_prev_menu_select = select_menu_select;
			if (key_up_press) {
				select_menu_select--;
			}
			else if (key_down_press) {
				select_menu_select++;
			}
			select_menu_select = clamp(select_menu_select, 0, clamp(select_list_length - 1, 0, select_list_length));
			
			// Update action option UI
			if (temp_prev_menu_select != select_menu_select) {
				// Reset option lerp
				select_option_lerp = 0;
				
				// Update Stats UI
				select_update_option = true;
			}
			
			// Check if Action Options Avaiable
			if (select_list != noone) {
				// Update Unit Stat UI
				if (select_update_option) {
					select_update_option = false;
				
					var temp_prev_stats_mode = draw_stats_mode;
					draw_stats_mode = checkUIType(select_list[select_menu_select]);
					if (temp_prev_stats_mode != draw_stats_mode) {
						draw_stats_alpha = 0;
					}
					select_item_stacks = 0;
					select_consumable_strength = 0;
				}
			
				// Use selected action option
				select_can_use = false;
				if (countItemInventory(unit_inventory, select_list[select_menu_select]) > 0) {
					select_can_use = true;
					
					// Display Consumable Stats
					if (global.item_data[select_list[select_menu_select], itemstats.type] == itemtypes.consumable) {
						select_item_stacks = countItemInventory(unit_inventory, select_list[select_menu_select]);
						select_consumable_strength = global.consumable_data[global.item_data[select_list[select_menu_select], itemstats.type_index], consumablestats.strength];
					}
					
					if (key_select_press) {
						// Check Item Type
						if (global.item_data[select_list[select_menu_select], itemstats.type] == itemtypes.weapon) {
							// Weapon Action Behaviour
							gui_mode = "targeting";
							target = 0;
							targets = noone;
							for (var c = 0; c < instance_number(oEnemy); c++) {
								targets[c] = instance_find(oEnemy, c);
								if (point_distance(x, y, targets[c].x, targets[c].y) < point_distance(x, y, targets[target].x, targets[target].y)) {
									target = c;
								}
							}
							target_draw_points = noone;
						}
						else if (global.item_data[select_list[select_menu_select], itemstats.type] == itemtypes.consumable) {
							// Consumable Action Behaviour
							if (unitUseConsumable(self, select_list[select_menu_select])) {
								removeItemInventory(unit_inventory, select_list[select_menu_select]);
								select_update_option = true;
								select_consumable_strength = 0;
							}
						}
					}
				}
			}
			else {
				select_can_use = true;
			}
			
			// Lerp select menu
			select_alpha = lerp(select_alpha, 1, menu_lerp_spd);
			select_menu_draw_pos = lerp(select_menu_draw_pos, select_menu_select, menu_lerp_spd);
			select_option_lerp = lerp(select_option_lerp, 1, menu_lerp_spd);
		}
		else if (gui_mode == "inventory") {
			// Inventory Management
		}
		else if (gui_mode == "targeting") {
			// Action & Magic Targeting
			if (targets != noone and array_length_1d(targets) > 0) {
				// Switch Targets
				if (key_left_press) {
					for (var q = target - 1; q > target - array_length_1d(targets); q--) {
						var temp_target_index = q;
						if (temp_target_index < 0) {
							temp_target_index += array_length_1d(targets);
						}
						if (targets[temp_target_index] != noone) {
							target = temp_target_index;
							break;
						}
					}
				}
				else if (key_right_press) {
					for (var q = target + 1; q < target + array_length_1d(targets); q++) {
						var temp_target_index = q;
						if (temp_target_index >= array_length_1d(targets)) {
							temp_target_index -= array_length_1d(targets);
						}
						if (targets[temp_target_index] != noone) {
							target = temp_target_index;
							break;
						}
					}
				}
				
				// Target Draw Variables
				if (targets[target] != noone) {
					// Target Variables
					var temp_target_sprite = targets[target].sprite_index;
					var temp_target_x_scale = targets[target].image_xscale;
					var temp_target_y_scale = targets[target].image_yscale;
					var temp_target_angle = targets[target].slope_angle;
		
					// Target Mask Edge Calculations
					var temp_bbox_left = sprite_get_bbox_left(temp_target_sprite) * temp_target_x_scale;
					var temp_bbox_right = (sprite_get_bbox_right(temp_target_sprite) + 1) * temp_target_x_scale;
					var temp_bbox_top = sprite_get_bbox_top(temp_target_sprite) * temp_target_y_scale;
					var temp_bbox_bottom = (sprite_get_bbox_bottom(temp_target_sprite) + 1) * temp_target_y_scale;
	
					temp_bbox_left -= sprite_get_xoffset(temp_target_sprite) * temp_target_x_scale;
					temp_bbox_bottom -= sprite_get_yoffset(temp_target_sprite) * temp_target_y_scale;
					temp_bbox_right -= sprite_get_xoffset(temp_target_sprite) * temp_target_x_scale;
					temp_bbox_top -= sprite_get_yoffset(temp_target_sprite) * temp_target_y_scale;
	
					var temp_point1_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_top);
					var temp_point1_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_top);
					var temp_point2_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_top);
					var temp_point2_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_top);
					var temp_point3_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_bottom);
					var temp_point3_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_bottom);
					var temp_point4_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_bottom);
					var temp_point4_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_bottom);
	
					target_draw_points[0] = lengthdir_x(temp_point1_dis, temp_point1_angle + temp_target_angle);
					target_draw_points[1] = lengthdir_y(temp_point1_dis, temp_point1_angle + temp_target_angle);
					target_draw_points[2] = lengthdir_x(temp_point2_dis, temp_point2_angle + temp_target_angle);
					target_draw_points[3] = lengthdir_y(temp_point2_dis, temp_point2_angle + temp_target_angle);
					target_draw_points[4] = lengthdir_x(temp_point3_dis, temp_point3_angle + temp_target_angle);
					target_draw_points[5] = lengthdir_y(temp_point3_dis, temp_point3_angle + temp_target_angle);
					target_draw_points[6] = lengthdir_x(temp_point4_dis, temp_point4_angle + temp_target_angle);
					target_draw_points[7] = lengthdir_y(temp_point4_dis, temp_point4_angle + temp_target_angle);
				}
				else {
					target_draw_points = noone;
				}
			}
		}
		
		// Lerp radial menu
		menu_alpha = lerp(menu_alpha, 0, menu_lerp_spd);
	}
	
	// Switch to player movement
	if (key_menu_press) {
		if (gui_mode == "select") {
			canmove = true;
			gui_mode = noone;
			game_manager.stop_time = false;
		}
		else {
			gui_mode = "select";
			draw_stats_mode = noone;
			select_consumable_strength = 0;
		}
	}
}

// Physics
if (!game_manager.stop_time) {
	if (platform_free(x, y + 1, platform_list)) {
		//Gravity
		grav_velocity += grav;
		grav_velocity *= grav_multiplier;
		grav_velocity = min(grav_velocity, max_grav);
		y_velocity += grav_velocity;
	}
	else {
		grav_velocity = 0;
	}

	var hspd = 0
	if (x_velocity != 0) {
		// Horizontal Collisions
		if (place_free(x + x_velocity, y)) {
			// Move Unit with horizontal velocity
			hspd += x_velocity;
		
			// Downward Slope collision check
			if (y_velocity == 0) {
				if (!place_free(x + x_velocity, y + slope_tolerance)) {
					var prev_slope_y = 0;
					for (var i = 0.5; i <= abs(slope_tolerance); i += 0.5) {
						if (!place_free(x + x_velocity, y + (sign(slope_tolerance) * i))) {
							y += sign(slope_tolerance) * prev_slope_y;
							break;
						}
						prev_slope_y = i;
					}
				}
			}
		}
		else {
			// Upward Slope collision check
			if (!place_free(x, y + 1) && place_free(x + x_velocity, y - slope_tolerance)) {
				for (var i = 0; i <= abs(slope_tolerance); i += 0.5) {
					if (place_free(x + x_velocity, y - (sign(slope_tolerance) * i))) {
						hspd += x_velocity;
						y -= sign(slope_tolerance) * i;
						break;
					}
				}
			}
			else {
				// Stop Unit momentum with Collision
				for (var i = abs(x_velocity); i > 0; i -= 0.5) {
					if (place_free(x + (i * sign(x_velocity)), y)) {
						hspd += i * sign(x_velocity);
						break;
					}
				}
				x_velocity = 0;
			}
		}
	}

	var vspd = 0;
	if (y_velocity != 0) {
		// Vertical Collisions
		if (platform_free(x, y + y_velocity, platform_list)) {
			vspd += y_velocity;
		}
		else {
			for (var i = abs(y_velocity); i > 0; i -= 0.5) {
				if (platform_free(x, y + (i * sign(y_velocity)), platform_list)) {
					vspd += i * sign(y_velocity);
					break;
				}
			}
			y_velocity = 0;
		
			// Squash and Stretch
			draw_xscale = 1 + squash_stretch;
			draw_yscale = 1 - squash_stretch;
		}
	}

	x += hspd;
	y += vspd;
}

// Animation
sin_val += draw_sin_spd;
if (sin_val > 1) {
	sin_val = 0;
}

if (!game_manager.stop_time) {
	draw_xscale = lerp(draw_xscale, 1, 0.1);
	draw_yscale = lerp(draw_yscale, 1, 0.1);

	if (hspd != 0) {
		// Set Sprite facing direction
		image_xscale = sign(hspd);	
	}

	if (!platform_free(x, y + 1, platform_list)) {
		if (hspd != 0) {
			sprite_index = walk_anim;
		}
		else {
			sprite_index = idle_anim;
		}
	}
	else {
		sprite_index = jump_anim;
		if (vspd < 0.15) {
			image_index = 0;
		}
		else if (vspd > 0.15) {
			image_index = 2;
		}
		else {
			image_index = 1;
		}
	}

	var slope_solid_obj = collision_line(x, y, x, y + 5, oSolid, false, false);
	if (slope_solid_obj != noone) {
		slope_angle = lerp(slope_angle, slope_solid_obj.image_angle, slope_lerp_spd);
		slope_offset = 0;
		if (slope_solid_obj.image_angle != 0) {
			slope_offset = slope_tolerance;
		}
	}
	else {
		slope_angle = lerp(slope_angle, 0, slope_lerp_spd);
		slope_offset = 0;
	}
}

// GUI & Menu Animation
if (gui_mode == "select") {
	// Set positions of radial menu options
	for (var i = 0; i < 5; i++) {
		var draw_sin = (sin((sin_val + (1 - (i / 5))) * 2 * pi) / 2) + 1;
		var temp_menu_pos = sin(((i + menu_radial_draw_pos + 1) / 5) * 2 * pi) * -32;
		var temp_menu_prox = abs(cos(((i + menu_radial_draw_pos + 1) / 5) * pi));
		menu_radial_node[i, 0] = x + temp_menu_pos + (lengthdir_y(48, slope_angle));
		menu_radial_node[i, 1] = (temp_menu_prox * 0.5) + 0.3 + (draw_sin * 0.2);
		menu_radial_node[i, 2] = 0.5 + (temp_menu_prox * 0.5);
	}
}

// Unit UI Animation
if (draw_stats_mode != noone) {
	draw_stats_alpha = lerp(draw_stats_alpha, 1, menu_lerp_spd);
	if (draw_stats_mode == "calories") {
		calorie_show = lerp(calorie_show, calories, 0.1);
	}
}
else {
	draw_stats_alpha = 0;
}

if (action < 1) {
	action_fade = 1;
}
else {
	action_fade = lerp(action_fade, 0, 0.025);
}

// ****DEBUG****
if (keyboard_check_pressed(ord("K"))) {
	if (draw_stats_mode == noone) {
		draw_stats_mode = "health";
	}
	else if (draw_stats_mode == "health") {
		draw_stats_mode = "calories";
		calorie_show = calories;
	}
	else {
		draw_stats_mode = noone;
	}
	draw_stats_alpha = 0;
}

if (keyboard_check_pressed(ord("I"))) {
	calories += 1000;
}

if (keyboard_check_pressed(ord("O"))) {
	calories -= 1000;
}


// Inventory
if (unit_inventory != noone) {
	unit_inventory.x = x;
	unit_inventory.y = y;
	unit_inventory.draw_inventory = (gui_mode == "inventory");
}