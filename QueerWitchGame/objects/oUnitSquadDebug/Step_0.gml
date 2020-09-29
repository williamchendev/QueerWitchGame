/// @description Insert description here
// You can write your code in this editor

alert = 1;
		
if (keyboard_check_pressed(ord("Q"))) {
	path_create = true;
	path_end_x = mouse_x;
	path_end_y = mouse_y;
}

// Inherit the parent event
event_inherited();

if (health_points <= 0) {
	instance_destroy(inventory);
	instance_destroy();
}

