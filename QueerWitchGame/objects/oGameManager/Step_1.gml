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
	if (keyboard_check_pressed(ord("0"))) {
		time_spd += 0.1;
	}
	else if (keyboard_check_pressed(ord("9"))) {
		time_spd -= 0.1;
	}
	time_spd = clamp(time_spd, 0, 1);
}

// Time Functions
global.deltatime = ((delta_time / 1000000) * fps) * time_spd;
global.realdeltatime = ((delta_time / 1000000) * fps);

global.deltatime = clamp(global.deltatime, 0, time_delta_clamp);
global.realdeltatime = clamp(global.realdeltatime, 0, time_delta_clamp);

// Game Fullscreen
if (keyboard_check_pressed(vk_f11)) {
	if (window_get_fullscreen()) {
		window_set_size(game_width * 2, game_height * 2);
		window_set_fullscreen(false);
	}
	else {
		window_set_size(1920, 1080);
		window_set_fullscreen(true);
	}
	surface_resize(application_surface, game_width, game_height);
}