/// @description Game Resolution & Settings

// Resolution
var temp_default_size = 2;
surface_resize(application_surface, game_width, game_height);
window_set_size(game_width * temp_default_size, game_height * temp_default_size);

// Game FPS Cap
game_set_speed(60, gamespeed_fps);