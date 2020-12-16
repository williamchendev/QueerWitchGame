/// @description Parallax Background Init
// Initializes variables and settings for the Parallax Background

// Settings
background_sprite[0] = sBackgroundMiddaySky1_A;
background_sprite[1] = sBackgroundMiddaySky1_B;
background_sprite[2] = sBackgroundMiddaySky1_C;
background_sprite[3] = sBackgroundMiddaySky1_D;
background_sprite[4] = sBackgroundMiddaySky1_E;

background_move_spd[0] = 0;
background_move_spd[1] = 0;
background_move_spd[2] = 0;
background_move_spd[3] = -0.005;
background_move_spd[4] = -0.2;

background_y = -60;
background_move_y_spd = 0.4;

background_scroll_spd[0] = 0;
background_scroll_spd[1] = 0.0001;
background_scroll_spd[2] = 0.0003;
background_scroll_spd[3] = 0;
background_scroll_spd[4] = 0;

// Variables
game_manager = instance_find(oGameManager, 0);
player_follow = noone;

background_x_offset = noone;
background_y_offset = 0;
background_scroll_value[0] = 0;
background_scroll_value[1] = 0;
background_scroll_value[2] = 0;
background_scroll_value[3] = 0;
background_scroll_value[4] = 0;