/// @description Unit Path Initialization Event
// Creates all the variables necessary for the Unit Pathfinder character

// Inherit Unit Initialization
event_inherited();

// Pathfinding Settings
ai_behaviour = true;

path_x_delta_tolerance = 3;
path_increment_index_radius = 5;

// Pathfinding Variables
pathing = false;
path_array = noone;
path_array_index = 0;

path_start_x = 0;
path_start_y = 0;

path_end_x = 0;
path_end_y = 0;

path_edge = noone;
path_jump_range_width = 0;
path_jump_range_height = 0;

path_jump_up = false;
path_jump_down = false;
path_double_jump = false;

// Debug Variables
path_debug_start_x = 0;
path_debug_start_y = 0;

path_debug_end_x = 0;
path_debug_end_y = 0;