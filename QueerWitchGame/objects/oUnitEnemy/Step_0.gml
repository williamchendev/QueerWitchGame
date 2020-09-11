/// @description Insert description here
// You can write your code in this editor

// Attack
if (sight_unit_nearest != noone) {
	debug_timer -= global.deltatime;
	if (debug_timer <= 0) {
		debug_timer = irandom_range(20, 40);
		key_select_press = true;
	}
}

if (x != oUnitPlayer.x) {
	image_xscale = sign(oUnitPlayer.x - x);
}

// Inherit the parent event
event_inherited();


if (health_points <= 0) {
	var temp_destroy_check = false;
	if (knockout) {
		if (knockout_timer <= 0) {
			temp_destroy_check = true;
		}
	}
	else {
		temp_destroy_check = true;
	}
	
	if (temp_destroy_check) {
		instance_destroy(inventory);
		instance_destroy();
	}
}

key_select_press = false;