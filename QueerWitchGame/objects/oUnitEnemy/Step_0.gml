/// @description Insert description here
// You can write your code in this editor

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