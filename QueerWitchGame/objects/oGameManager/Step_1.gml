/// @description Early Step Event

// Update Camera position variables
camera_width = camera_get_view_width(view_camera[0]);
camera_height = camera_get_view_height(view_camera[0]);
camera_x = camera_get_view_x(view_camera[0]);
camera_y = camera_get_view_y(view_camera[0]);

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