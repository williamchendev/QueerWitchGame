/// @description Insert description here
// You can write your code in this editor

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
		
		key_select_press = keyboard_check_pressed(game_manager.select_check);
		key_cancel_press = keyboard_check_pressed(game_manager.cancel_check);
		key_menu_press = keyboard_check_pressed(game_manager.menu_check);
		
		key_command = keyboard_check(game_manager.command_check);
	}
}

// Physics & Combat & Unit Behaviour Inheritance
event_inherited();

// Command Mode Behaviour
if (canmove) {
	if (command) {
		// Time Lerp
		if (command_lerp_time) {
			game_manager.time_spd = lerp(game_manager.time_spd, 0.2, 0.3 * global.realdeltatime);
			if (game_manager.time_spd < 0.25) {
				command_lerp_time = false;
				game_manager.time_spd = 0.2;
			}
		}
		
		// Command Mode Enabled Behaviour
		if (key_command) {
			// Command Mode Behaviour
			
		}
		else {
			// Disable Command
			command = false;
			command_lerp_time = true;
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
}