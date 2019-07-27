/// @description Level Editor Initialization Event
// Initializes all the variables and properties of the level editor

// Editor Data
editorData();

// Menu Settings
menu_screen = true;
new_block_screen = false;

// Menu Variables
menu_option_play_demo_alpha = 0;
menu_option_new_level_alpha = 0;
menu_option_open_level_alpha = 0;
menu_option_new_block_alpha = 0;
menu_option_open_block_alpha = 0;

block_select = -1;
block_width_select = "";
block_height_select = "";
block_name_select = "";

// Editor Settings
enum editormode {
	block,
	level,
	text
}
editor_mode = editormode.block;

editor_tools = noone;
editor_objects = noone;

editor_spd = 2;
editor_grid = true;

min_block_width = 4;
max_block_width = 80;
min_block_height = 7;
max_block_height = 400;

// Editor Variables
block_width = 0;
block_height = 0;

// Camera Settings
camera_follow = true;	
camera_follow_spd = 0.05;