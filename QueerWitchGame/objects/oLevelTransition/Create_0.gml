/// @description Insert description here
// You can write your code in this editor

// Level Settings
transition_room_goto = rTutorialLevel_DoorsPlatforms;

// Transition Settings
transition_spd = 0.018;
transition_duration = 1;

transition_color = c_black;

// Variables
transition_active = false;
transition_other_room_active = false;
transition_timer = 0;
transition_alpha = 0;

transition_player_unit_check = false;
transition_player_unit_exists = true;
transition_player_unit = noone;

// Debug
game_manager = instance_find(oGameManager, 0);

camera_offset = 20;