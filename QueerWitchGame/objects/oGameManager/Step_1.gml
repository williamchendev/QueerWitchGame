/// @description Early Step Event

// Update Camera position variables
camera_width = camera_get_view_width(view_camera[0]);
camera_height = camera_get_view_height(view_camera[0]);
camera_x = camera_get_view_x(view_camera[0]);
camera_y = camera_get_view_y(view_camera[0]);

// Toggle Debug Mode
if (keyboard_check_pressed(vk_f7)) {
	global.debug = !global.debug;	
}

// Debug Mode Functions
if (global.debug) {
	// Camera Movement
	var temp_camera_move_x = 0;
	var temp_camera_move_y = 0;
	
	if (keyboard_check(ord("W"))) {
		 temp_camera_move_y = -debug_camera_spd;
	}
	else if (keyboard_check(ord("S"))) {
		temp_camera_move_y = debug_camera_spd;
	}
	
	if (keyboard_check(ord("A"))) {
		temp_camera_move_x = -debug_camera_spd;
	}
	else if (keyboard_check(ord("D"))) {
		temp_camera_move_x = debug_camera_spd;
	}
	
	camera_set_view_pos(view_camera[0], camera_x + temp_camera_move_x, camera_y + temp_camera_move_y);
}

// Game Fullscreen
if (keyboard_check_pressed(vk_f11)) {
	if (window_get_fullscreen()) {
		window_set_size(960, 540);
		window_set_fullscreen(false);
	}
	else {
		window_set_size(1920, 1080);
		window_set_fullscreen(true);
	}
	surface_resize(application_surface, 480, 270);
}