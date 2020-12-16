/// @description Title Screen Init Event
// Creates all the variables necessary for the Title Screen

// Game Manager
game_manager = instance_find(oGameManager, 0);

// Deadname Title Settings
deadname_title_sprite = sDeadnameTitle;
deadname_title_color = make_colour_rgb(104, 1, 1);
deadname_title_alpha_spd = 0.008;

deadname_title_y_offset = 42;

// Inno Spelman Text Settings
inno_spelman_text = "Inno Spelman's";

inno_spelman_text_x_offset = 140;
inno_spelman_text_y_offset = 36;

inno_spelman_text_alpha_spd = 0.015;

// Play Option Settings
play_fade_spd = 0.03;
play_room_goto = rTutorialLevel_Movement;

// Options Settings
options_text = "Press F11 for Fullscreen\n\nCheck back in 2 years for more options...";

// Credits Settings
credits_text = "Design, Programming, Animation: Inno Spelman\n\nGame, Story, & Level Design: Amir Budhai\n\nArt Direction & Music: Toni Chadwell";

// Title Button Settings
play_button_sprite = sPraxisIconTitle;
play_button_sprite_y_offset = 6;

options_button_sprite = sOptionsIconTitle;
options_button_sprite_y_offset = 50;

credits_button_sprite = sCreditsIconTitle;
credits_button_sprite_y_offset = 96;

end_button_sprite = sEndIconTitle;
end_button_sprite_y_offset = 142;

// Title Button Animation Settings
title_button_move_spd = 0.25;
title_button_move_range = 3;

// Variables
play_active = false;
options_active = false;
credits_active = false;

play_fade_timer = 0;

deadname_title_alpha = 0;
inno_spelman_text_alpha = 0;
inno_spelman_draw_text = "";

button_index = -1;
button_move_timer = 0;

button_move_offset_x1 = 0;
button_move_offset_y1 = 0;
button_move_offset_x2 = 0;
button_move_offset_y2 = 0;

// Debug
sprite_index = -1;