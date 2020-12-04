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
						temp_weapon.bursts += min(max(temp_weapon.burst, 1), temp_weapon.bullets);
						temp_weapon.bursts_timer = 0;
						temp_weapon.bullets -= temp_weapon.bursts;
					}
					crunch = true;
				}
			}
		}
		else {
			// Reset Crunch
			canmove = false;
			game_manager.time_spd = 0.25;
			sprite_index = aim_animation;
			x_velocity = 0;
			if (ds_list_size(temp_weapon.flash_timer) < 1) {
				crunch = false;
				canmove = true;
				game_manager.time_spd = 1;
			}
		}
	}
}