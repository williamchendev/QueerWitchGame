/// @description Unit Path Initialization Event
// Creates all the variables necessary for the Unit Pathfinder character

// Inherit Unit Initialization
event_inherited();

// Ai Behaviour Settings
ai_behaviour = true;
ai_behaviour_mode = "sentry";

// Sight Settings
sight = true;

sight_origin_x = 0;
sight_origin_y = -40;

sight_radius = 280;
sight_arc = 15;
sight_interpolate = 5;

// Pathfinding Settings
path_x_delta_tolerance = 3;
path_increment_index_radius = 5;

// Sight Variables
sight_angle = 0;

sight_unit_num = 0;
sight_unit_array = noone;
sight_unit_nearest = noone;

sight_unit_seen = false;
sight_unit_seen_x = 0;
sight_unit_seen_y = 0;

// Pathfinding Variables
pathing = false;
path_array = noone;
path_array_index = 0;

path_create = false;

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
path_debug_draw = false;

path_debug_start_x = 0;
path_debug_start_y = 0;

path_debug_end_x = 0;
path_debug_end_y = 0;