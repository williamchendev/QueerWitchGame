/// @description Insert description here
// You can write your code in this editor

// Attack
if (collision_line(weapon_x, weapon_y, oUnitPlayer.weapon_x, oUnitPlayer.weapon_y, oSolid, false, true) != noone) {
	debug_timer = irandom_range(120, 480);
}
else {
	debug_timer--;
	if (debug_timer <= 0) {
		debug_timer = irandom_range(120, 480);
		key_select_press = true;
	}
}

if (x != oUnitPlayer.x) {
	image_xscale = sign(oUnitPlayer.x - x);
}

// Inherit the parent event
event_inherited();

if (health_points <= 0) {
	instance_destroy(inventory);
	instance_destroy();
}

key_select_press = false;