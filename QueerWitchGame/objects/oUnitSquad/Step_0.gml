/// @description Insert description here
// You can write your code in this editor

key_left = false;
key_right = false;
key_up = false;
key_down = false;

key_left_press = false;
key_right_press = false;
key_up_press = false;
key_down_press = false;
		
//key_select_press = keyboard_check_pressed(game_manager.select_check);
key_select_press = false;
		
key_fire_press = false;
key_aim_press = false;
key_reload_press = false;
		
if (keyboard_check_pressed(ord("Q"))) {
	path_create = true;
	path_end_x = mouse_x;
	path_end_y = mouse_y;
}

if (sight_unit_nearest != noone) {
	debug_timer -= global.deltatime;
	if (debug_timer <= 0) {
		debug_timer = irandom_range(20, 40);
		key_select_press = true;
	}
}


// Inherit the parent event
event_inherited();

if (health_points <= 0) {
	instance_destroy(inventory);
	instance_destroy();
}

