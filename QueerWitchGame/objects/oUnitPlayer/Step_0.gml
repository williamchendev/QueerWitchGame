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

// Swap Weapons (Debug)
if (keyboard_check_pressed(ord("P"))) {
	if (weapons[0].object_index == oGun_FAL) {
		instance_destroy(weapons[0]);
		weapons[0] = instance_create_layer(x, y, layers[3], oGun_M14);
		weapons[0].equip = true;
	}
	else {
		instance_destroy(weapons[0]);
		weapons[0] = instance_create_layer(x, y, layers[3], oGun_FAL);
		weapons[0].equip = true;
	}
}

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
			if (key_select_press) {
				// Select Target
				if (target != ds_list_find_value(targets, targets_index)) {
					target = ds_list_find_value(targets, targets_index);
				}
				else {
					target = noone;
				}
			}
			else if (key_left_press) {
				// Move Target Select Index Left
				targets_index--;
				if (targets_index < 0) {
					targets_index = ds_list_size(targets) - 1;
				}
			}
			else if (key_right_press) {
				// Move Target Select Index Right
				targets_index++;
				if (targets_index >= ds_list_size(targets)) {
					targets_index = 0;
				}
			}
			
			command_time = true;
			global.deltatime = global.deltatime * command_time_mod;
			
			if (instance_exists(oTargetUI)) {
				var temp_target_ui = instance_find(oTargetUI, 0);
				temp_target_ui.target = ds_list_find_value(targets, targets_index);
				temp_target_ui.selected = false;
				if (temp_target_ui.target == target) {
					temp_target_ui.selected = true;
				}
			}
			
			// Reset Keys
			/*
			key_left = false;
			key_right = false;
			key_up = false;
			key_down = false;
			*/
			key_select_press = false;
			
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
			// Disable Command
			command = false;
			command_lerp_time = true;
			
			instance_destroy(oTargetUI);
			ds_list_destroy(targets);
			targets = -1;
			targets_index = -1;
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
			
			// Equiped Weapon
			var temp_weapon_distance = 264;
			if (weapons != noone) {
				for (var w = 0; w < array_length_1d(weapons); w++) {
					// Find Equiped Weapon
					if (weapons[w].equip) {
						temp_weapon_distance = max(temp_weapon_distance, weapons[w].range);
						break;
					}
				}
			}
			
			// Establish Targets
			var temp_targets = ds_list_create();
			for (var t = 0; t < instance_number(oUnit); t++) {
				// Check if Target is within range
				var temp_unit = instance_find(oUnit, t);
				if (temp_unit == self) {
					continue;
				}
				else if (point_distance(x, y, temp_unit.x, temp_unit.y) < temp_weapon_distance) {
					// Add Target to Sorting List
					ds_list_add(temp_targets, temp_unit);
				}
			}
			
			// Sort Targets
			targets = ds_list_create();
			while (ds_list_size(temp_targets) > 0) {
				var temp_nearest_unit = 0;
				for (var q = 0; q < ds_list_size(temp_targets); q++) {
					var temp_near_unit = ds_list_find_value(temp_targets, temp_nearest_unit);
					var temp_near_distance = point_distance(x, y, temp_near_unit.x, temp_near_unit.y);
					var temp_check_unit = ds_list_find_value(temp_targets, q);
					var temp_check_distance = point_distance(x, y, temp_check_unit.x, temp_check_unit.y);
					if (temp_check_distance <= temp_near_distance) {
						temp_nearest_unit = q;
					}
				}
				ds_list_add(targets, ds_list_find_value(temp_targets, temp_nearest_unit));
				ds_list_delete(temp_targets, temp_nearest_unit);
			}
			ds_list_destroy(temp_targets);
			temp_targets = -1;
			targets_index = 0;
			
			// Set Target Index to Selected Target
			if (target != noone) {
				for (var t = 0; t < ds_list_size(targets); t++) {
					if (target == ds_list_find_value(targets, t)) {
						targets_index = t;
					}
				}
			}
			
			// Create Target Reticle
			if (!instance_exists(oTargetUI)) {
				if (ds_list_size(targets) > 0) {
					var temp_target_ui = instance_create_layer(x, y, layers[3], oTargetUI);
					temp_target_ui.target = ds_list_find_value(targets, targets_index);
				}
			}
		}
	}
}

// Physics & Combat & Unit Behaviour Inheritance
event_inherited();

// Reset Command Time
if (command_time) {
	command_time = false;
	global.deltatime = global.deltatime / command_time_mod;
}