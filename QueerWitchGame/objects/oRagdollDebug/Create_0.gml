/// @description Ragdoll Initialization Event
// Creates all the variables necessary for the Ragdoll Entity

// Collider Settings
collider_points = noone;

/*
collider_points[0, 0] = -48;
collider_points[0, 1] = -24;

collider_points[1, 0] = 48;
collider_points[1, 1] = -24;

collider_points[2, 0] = 48;
collider_points[2, 1] = 24;

collider_points[3, 0] = -48;
collider_points[3, 1] = 24;
*/

collider_points[0, 0] = -24;
collider_points[0, 1] = -24;

collider_points[1, 0] = 24;
collider_points[1, 1] = -24;

collider_points[2, 0] = 24;
collider_points[2, 1] = 24;

collider_points[3, 0] = -24;
collider_points[3, 1] = 24;

collider_edge_interpolation = 1;
collider_edge_check_distance = 1;

// Gravity Settings
grav_spd = 0.026;
grav_multiplier = 0.93;
max_grav_spd = 2;

// Physics Settings
slope_tolerance = 1;

// Variables
x_velocity = 0;
y_velocity = 0;
grav_velocity = 0;

// Debug
draw_x = noone;
draw_y = noone;
draw_color = noone;
draw_num = 0;