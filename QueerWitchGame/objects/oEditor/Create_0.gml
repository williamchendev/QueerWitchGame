/// @description Level Editor Initialization Event
// Initializes all the variables and properties of the level editor

// Editor Data
editorData();

// Editor Settings
enum editortypes {
	start,
	play,
	level,
	block
}

editor_mode = editortypes.start;

editor_click = true;
editor_delete = false;
editor_tools = noone;
editor_ribbon = noone;
editor_objects = noone;
editor_cursor = -1;

editor_spd = 2;

editor_snap = true;
editor_grid = true;

// Block Editor Variables
block_width = 0;
block_height = 0;
block_filename = "";

block_tileset_index = 0;
block_tileset = noone;

// Camera Settings
camera_follow = true;	
camera_follow_spd = 0.05;