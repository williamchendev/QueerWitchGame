/// @description Knockout Draw Event
// Draws the Knockout background color to the screen

// Knockout Color
var temp_color = make_color_rgb(130, 0, 10);

// Set Color
draw_set_alpha(1);
draw_set_color(temp_color);

// Draw Background
var temp_game_manager = instance_find(oGameManager, 0);
draw_rectangle(temp_game_manager.camera_x - 10, temp_game_manager.camera_y - 10, temp_game_manager.camera_x + temp_game_manager.camera_width + 10, temp_game_manager.camera_y + temp_game_manager.camera_height + 10, false);

// Reset Color
draw_set_color(c_white);