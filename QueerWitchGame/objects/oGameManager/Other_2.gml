/// @description Game Resolution & Settings

// Resolution
surface_resize(application_surface, game_width, game_height);
window_set_size(game_width * 2, game_height * 2);

// Game FPS Cap
game_set_speed(60, gamespeed_fps);