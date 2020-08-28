/// @description Unit Path Initialization Event
// Creates all the variables necessary for the Unit Pathfinder character

// Inherit Unit Initialization
event_inherited();

// Pathfinding Settings
pathing = true;

path_movement_radius = 5;

// Pathfinding Variables
path_array = noone;
path_array_index = 0;

path_start_x = 0;
path_start_y = 0;

path_end_x = 0;
path_end_y = 0;

// Debug Variables
path_debug_start_x = 0;
path_debug_start_y = 0;

path_debug_end_x = 0;
path_debug_end_y = 0;