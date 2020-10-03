/// @description Insert description here
// You can write your code in this editor

// Game Manager Singleton
game_manager = instance_find(oGameManager, 0);

// Interact Settings
active = true;

// Animation Settings
interact_select = false;
interact_select_draw_spd = 0.15;
interact_select_outline_color = c_white;

// Interact Variables
interact_action = false;

interact_obj = noone;
interact_unit = noone;

// Animation Variables
interact_select_draw_value = 0;

// Surface Variables
interact_surface = noone;