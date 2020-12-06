/// @description Insert description here
// You can write your code in this editor

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
			if (keyboard_check_pressed(ord("F"))) {
			// Equipped Weapon & Combat Unit Behaviour
				if (temp_weapon.bullets > 0) {
					temp_weapon.ignore_id = team_id;
					while (temp_weapon.bullets > 0) {
						var temp_burst_num = min(max(temp_weapon.burst, 1), temp_weapon.bullets);
						temp_weapon.bursts += temp_burst_num;
						temp_weapon.bursts_timer = 0;
						temp_weapon.bullets -= temp_burst_num;
					}
					crunch = true;
					crunch_x = temp_weapon.x;
					crunch_y = temp_weapon.y;
					crunch_bursts = temp_weapon.bursts;
					crunch_weapon_move_timer = 0;
				}
			}
		}
		else {
			// Player & Game Manager Behaviour
			reload = false;
			canmove = false;
			x_velocity = 0;
			game_manager.time_spd = 0.25;
			sprite_index = aim_animation;
			
			// Crunch Bursts
			if (temp_weapon.bursts < crunch_bursts) {
				crunch_bursts = temp_weapon.bursts;
				temp_weapon.bursts_timer = crunch_weapon_fire_delay;
			}
			
			// Crunch Burst Movement
			if (temp_weapon.bursts > 0) {
				crunch_weapon_move_timer -= global.realdeltatime * crunch_weapon_move_spd;
				if (crunch_weapon_move_timer <= 0) {
					temp_weapon.x = crunch_x + random_range(-crunch_weapon_move_range / 2, crunch_weapon_move_range / 2);
					temp_weapon.y = crunch_y + random_range(-crunch_weapon_move_range / 2, crunch_weapon_move_range / 2);
					crunch_weapon_move_timer += 1;
				}
			}
			
			// Reset Crunch
			if (ds_list_size(temp_weapon.flash_timer) < 1) {
				crunch = false;
				canmove = true;
				game_manager.time_spd = 1;
			}
		}
	}
}