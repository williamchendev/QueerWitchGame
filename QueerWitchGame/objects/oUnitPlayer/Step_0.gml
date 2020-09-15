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
		
		key_fire_press = mouse_check_button_pressed(mb_left);
		key_aim_press = mouse_check_button(mb_right);
		key_reload_press = keyboard_check_pressed(game_manager.reload_check);
		
		key_select_press = keyboard_check_pressed(game_manager.select_check);
		key_cancel_press = keyboard_check_pressed(game_manager.cancel_check);
		key_menu_press = keyboard_check_pressed(game_manager.menu_check);
		
		key_command = keyboard_check(game_manager.command_check);
	}
}

// Player Unit Behaviour
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
		if (inventory_show) {
			// Inventory Behaviour
			if (key_menu_press) {
				inventory_show = false;
			}
		}
		
		if (!inventory_show) {
			// Command Mode Targeting Behaviour
			if (key_command) {
				
			}
			else {
				// Disable Command Mode
				command = false;
				command_lerp_time = true;
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
		key_select_press = false;
			
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
			}
		}
		
		// Command Mode Disabled Behaviour
		if (key_command) {
			// Enable Command
			command = true;
			command_lerp_time = true;
		}
	}
	
	// Aim Behaviour
	targeting = false;
	if (key_aim_press) {
		targeting = true;
		target_x = mouse_x;
		target_y = mouse_y;
	}
}

// Physics & Combat & Unit Behaviour Inheritance
event_inherited();

// Reset Command Time
if (command_time) {
	command_time = false;
	global.deltatime = global.deltatime / command_time_mod;
}