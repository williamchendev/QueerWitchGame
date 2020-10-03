/// @description Unit Update Event
// performs the calculations necessary for the Unit's behavior

// Key Checks (Player Input)
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
		
		key_interact_press = keyboard_check_pressed(game_manager.interact_check);
		key_inventory_press = keyboard_check_pressed(game_manager.inventory_check);
		
		key_fire_press = mouse_check_button(mb_left);
		key_aim_press = mouse_check_button(mb_right);
		key_reload_press = keyboard_check_pressed(game_manager.reload_check);
		
		key_command = keyboard_check(game_manager.command_check);
		
		cursor_x = mouse_x;
		cursor_y = mouse_y;
	}
}
else {
	// Squad Behaviour
	var temp_ai_follow_valid = false;
	if (ai_behaviour) {
		if (ai_follow) {
			if (ai_follow_unit != noone) {
				if (instance_exists(ai_follow_unit)) {
					// Squad Unit is Valid & Exists
					temp_ai_follow_valid = true;
					
					// Squad Unit is Player
					if (ai_follow_unit.player_input) {
						squad_aim = true;
					}
				}
			}
		}
	}
	
	// Physics & Combat & Unit Behaviour Inheritance
	event_inherited();
	
	// Set Squad Unit Outline
	if (temp_ai_follow_valid) {		
		// Set Unit to have Squad Outline
		if (is_undefined(ds_map_find_value(game_manager.surface_manager.units_outline, self))) {
			ds_map_add(game_manager.surface_manager.units_outline, self, squad_outline_color);
		}
		else if (ds_map_find_value(game_manager.surface_manager.units_outline, self) != c_white) {
			ds_map_replace(game_manager.surface_manager.units_outline, self, squad_outline_color);
		}
		// Set Following Unit to have Squad Outline
		if (is_undefined(ds_map_find_value(game_manager.surface_manager.units_outline, ai_follow_unit))) {
			ds_map_add(game_manager.surface_manager.units_outline, ai_follow_unit, squad_outline_color);
		}
		else if (ds_map_find_value(game_manager.surface_manager.units_outline, ai_follow_unit) != c_white) {
			ds_map_replace(game_manager.surface_manager.units_outline, ai_follow_unit, squad_outline_color);
		}
	}
	squad_aim = false;
	
	// End Event
	return;
}

// Reset Interact Section
with (oInteract) {
	interact_select = false;
}

// Player Unit Behaviour
var temp_fire_press = key_fire_press;
var temp_aim_press = key_aim_press;
if (canmove) {
	// Command Mode Behaviour
	if (command) {
		// Time Lerp
		if (command_lerp_time) {
			game_manager.time_spd = lerp(game_manager.time_spd, 0.2, 0.3 * global.realdeltatime);
			if (game_manager.time_spd < 0.25) {
				command_lerp_time = false;
				game_manager.time_spd = 0.2;
			}
		}
		
		// Command Mode Behaviour
		if (!inventory_show) {
			// Select Unit
			unit_select_hover = noone;
			for (var i = 0; i < instance_number(oUnitSquad); i++) {
				// Iterate Through Squad Units
				var temp_unit_squad = instance_find(oUnitSquad, i);
				
				// Hitbox Variables
				var temp_hitbox_p1_x = temp_unit_squad.x + temp_unit_squad.hitbox_left_top_x_offset - unit_select_hitbox_offset;
				var temp_hitbox_p1_y = temp_unit_squad.y + temp_unit_squad.hitbox_left_top_y_offset - unit_select_hitbox_offset;
				var temp_hitbox_p2_x = temp_unit_squad.x + temp_unit_squad.hitbox_right_bottom_x_offset + unit_select_hitbox_offset;
				var temp_hitbox_p2_y = temp_unit_squad.y + temp_unit_squad.hitbox_right_bottom_y_offset + unit_select_hitbox_offset;
					
				if (point_in_rectangle(cursor_x, cursor_y, temp_hitbox_p1_x, temp_hitbox_p1_y, temp_hitbox_p2_x, temp_hitbox_p2_y)) {
					if (key_aim_press and !old_aim_press) {
						if (unit_select != noone and unit_select != temp_unit_squad) {
							with (unit_select) {
								path_create = true;
								path_end_x = temp_unit_squad.x;
								path_end_y = temp_unit_squad.y;
								
								ai_follow = true;
								ai_command = false;
								ai_follow_unit = temp_unit_squad;
								ai_follow_combat_timer = 0;
							}
							unit_select = noone;
							key_aim_press = false;
						}
					}
					else if (key_fire_press and !old_fire_press) {
						if (temp_unit_squad != self) {
							unit_select = temp_unit_squad;
							key_fire_press = false;
						}
					}
					else {
						unit_select_hover = temp_unit_squad;
					}
						
					break;
				}
			}
			
			// Deselect Unit
			if (key_fire_press and !old_fire_press) {
				unit_select = noone;
			}
			
			// Move Unit
			if (key_aim_press and !old_aim_press) {
				if (unit_select != noone) {
					with (unit_select) {
						path_create = true;
						path_end_x = other.cursor_x;
						path_end_y = other.cursor_y;
						
						ai_command = true;
						ai_follow = false;
						ai_follow_unit = noone;
						ai_follow_active = false;
					}
				}
			}
			
			// Set Outline Overlay
			var temp_unit_select_array = noone;
			if (unit_select != noone) {
				// Set Units Selected
				temp_unit_select_array[0] = unit_select;
			}
			if (instance_exists(game_manager)) {
				// Set Unit Outline
				if (temp_unit_select_array != noone) {
					for (var q = 0; q < array_length_1d(temp_unit_select_array); q++) {
						if (is_undefined(ds_map_find_value(game_manager.surface_manager.units_outline, temp_unit_select_array[q]))) {
							ds_map_add(game_manager.surface_manager.units_outline, temp_unit_select_array[q], c_white);
						}
						else {
							ds_map_replace(game_manager.surface_manager.units_outline, temp_unit_select_array[q], c_white);
						}
					}
				}
			}
			
			// Disable Command Mode
			if (!key_command) {
				command = false;
				command_lerp_time = true;
			}
		}
		else {
			// Command Inventory Mode Behaviour
			if (key_inventory_press) {
				// Disable Command Mode & Inventory
				command = false;
				command_lerp_time = true;
				inventory_show = false;
			}
		}
		
		// Apply Slow Down Effect
		command_time = true;
		global.deltatime = global.deltatime * command_time_mod;
		
		// Prevent Attacking/Jumping in Inherited Event
		key_up = false;
		key_up_press = false;
		key_down = false;
		key_down_press = false;
		
		key_fire_press = false;
		key_aim_press = false;
		key_reload_press = false;
			
		// Maintain Velocity while in Command Mode
		if (x_velocity < 0) {
			key_left = true;
			key_right = false;
		}
		else if (x_velocity > 0) {
			key_left = false;
			key_right = true;
		}
		else {
			key_left = false;
			key_right = false;
		}
	}
	else {
		// Time Lerp
		if (command_lerp_time) {
			game_manager.time_spd = lerp(game_manager.time_spd, 1, 0.1 * global.realdeltatime);
			if (game_manager.time_spd > 0.95) {
				command_lerp_time = false;
				game_manager.time_spd = 1;
				
				// Disable Unit Select Surface
				if (instance_exists(game_manager)) {
					game_manager.surface_manager.calc_unit_overlay = false;
				}
			}
		}
		
		// Command Mode Disabled Behaviour
		if (key_command or key_inventory_press) {
			// Enable Command
			command = true;
			command_lerp_time = true;
			
			// Reset Unit Select
			unit_select = noone;
			
			// Enable Inventory
			if (key_inventory_press) {
				inventory_show = true;
			}
			
			// Enable Unit Select Surface
			if (instance_exists(game_manager)) {
				game_manager.surface_manager.calc_unit_overlay = true;
			}
		}
		
		// Interact Behaviour
		if (interact_collision_list != noone) {
			// Interate Through Interact Objects
			for (var q = 0; q < array_length_1d(interact_collision_list); q++) {
				// Cursor Hover
				if (position_meeting(cursor_x, cursor_y, interact_collision_list[q])) {
					interact_collision_list[q].interact_select = true;
					break;
				}
			}
		}
	}
	
	// Aim Behaviour
	targeting = false;
	if (key_aim_press) {
		targeting = true;
		target_x = cursor_x;
		target_y = cursor_y;
	}
}

// Physics & Combat & Unit Behaviour Inheritance
event_inherited();


// Reset Command Time
if (command_time) {
	command_time = false;
	global.deltatime = global.deltatime / command_time_mod;
}

// Old Click
old_fire_press = temp_fire_press;
old_aim_press = temp_aim_press;