/// @description Insert description here
// You can write your code in this editor

if (crunch) {
	canmove = false;
}

// Inherit the parent event
event_inherited();

// Weapons
var temp_weapon = noone;
if (instance_exists(inventory)) {
	for (var i = 0; i < ds_list_size(inventory.weapons); i++) {
		// Find Indexed Weapon
		var temp_weapon_index = ds_list_find_value(inventory.weapons, i);
	
		// Set Equipped Weapon
		if (temp_weapon_index.equip) {
			temp_weapon = temp_weapon_index;
		}
	}
}

if (temp_weapon != noone) {
	if ((temp_weapon.object_index == oFirearm) or (object_is_ancestor(temp_weapon.object_index, oFirearm))) {
		// Crunch
		if (!crunch) {
			// Screen Shake Bursts
			if (screen_shake_shots > temp_weapon.bullets - ds_list_size(temp_weapon.flash_timer)) {
				if (!reload) {
					camera_screen_shake = true;
					camera_screen_shake_timer = 1;
				}
			}
			else {
				camera_screen_shake = false;
			}
			screen_shake_shots = temp_weapon.bullets - ds_list_size(temp_weapon.flash_timer);
			
			if (keyboard_check_pressed(ord("F"))) {
			// Equipped Weapon & Combat Unit Behaviour
				if (temp_weapon.bullets > 0) {
					temp_weapon.ignore_id = team_id;
					/*
					while (temp_weapon.bullets > 0) {
						var temp_burst_num = min(max(temp_weapon.burst, 1), temp_weapon.bullets);
						temp_weapon.bursts += temp_burst_num;
						temp_weapon.bursts_timer = 0;
						temp_weapon.bullets -= temp_burst_num;
					}
					*/
					var temp_burst_num = min(max(temp_weapon.burst, 1), temp_weapon.bullets);
					temp_weapon.bursts += temp_burst_num;
					temp_weapon.bursts_timer = 0;
					temp_weapon.bullets -= temp_burst_num;
					
					crunch = true;
					crunch_x = temp_weapon.x;
					crunch_y = temp_weapon.y;
					crunch_bursts = temp_weapon.bursts;
					crunch_weapon_move_timer = 0;
					crunch_player_input = player_input;
					
					player_input = false;
					camera_lock = true;
					camera_lock_x = camera_x + (game_manager.game_width / 2);
					camera_lock_y = camera_y + (game_manager.game_height / 2);
					
					camera_screen_shake = true;
					camera_screen_shake_timer = 1;
				}
			}
		}
		else {
			// Player & Game Manager Behaviour
			canmove = true;
			x_velocity = 0;
			game_manager.time_spd = 0.25;
			sprite_index = aim_animation;
			camera_screen_shake = false;
			camera_screen_shake_lrg = false;
			temp_weapon.use_realdeltatime = false;
			temp_weapon.recoil_angle_shift = lerp(temp_weapon.recoil_angle_shift, 0, global.realdeltatime * crunch_weapon_recoil_resist);
			
			// Crunch Burst Movement
			if (temp_weapon.bullets > 0) {
				camera_screen_shake_lrg = true;
				temp_weapon.use_realdeltatime = true;
				if (crunch_bursts > temp_weapon.bursts) {
					camera_screen_shake = true;
					camera_screen_shake_timer = 1;
					crunch_bursts = temp_weapon.bursts;
				}
				if (temp_weapon.bursts <= 0) {
					var temp_burst_num = min(max(temp_weapon.burst, 1), temp_weapon.bullets);
					temp_weapon.bursts += temp_burst_num;
					temp_weapon.bursts_timer = 0;
					temp_weapon.bullets -= temp_burst_num;
					crunch_bursts = temp_weapon.bursts;
				}
				
				crunch_weapon_move_timer -= global.realdeltatime * crunch_weapon_move_spd;
				if (crunch_weapon_move_timer <= 0) {
					temp_weapon.x = crunch_x + random_range(-crunch_weapon_move_range / 2, crunch_weapon_move_range / 2);
					temp_weapon.y = crunch_y + random_range(-crunch_weapon_move_range / 2, crunch_weapon_move_range / 2);
					crunch_weapon_move_timer += 1;
				}
			}
			else {
				// Reset Crunch
				if (ds_list_size(temp_weapon.flash_timer) < 1) {
					crunch = false;
					game_manager.time_spd = 1;
					player_input = crunch_player_input;
					camera_lock = false;
					screen_shake_shots = 0;
				}
			}
		}
	}
}