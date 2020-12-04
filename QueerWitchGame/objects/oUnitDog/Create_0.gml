/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Physics Settings
spd = 5; // Running Speed
walk_spd = 1; // Walk Speed

jump_spd = 1.4; // Jumping Speed
double_jump_spd = 3; // Double Jumping Seed
hold_jump_spd = 0.45; // Added Jump Speed when the Jump Button is held
jump_decay = 0.81; // Decay of the Jumping Upwards Velocity

grav_spd = 0.026; // Force of Downward Gravity
grav_multiplier = 0.93; // Dampening Multiplyer of the Downward Velocity (Makes gravity smoother)
max_grav_spd = 2; // Max Speed of Unit's Downward Velocity

slope_tolerance = 3; // Tolerance for walking up slopes in pixels
slope_angle_lerp_spd = 0.1; // Speed to lerp the angle to the slope the player is standing on

// Beahviour Settings
canmove = true;

team_id = "unassigned";

health_show = false;
health_points = 6;
max_health_points = 6;

// Animation Settings
idle_animation = sArkovianBurgerDog;
walk_animation = sArkovianBurgerDog;
jump_animation = sArkovianBurgerDog;
aim_animation = sArkovianBurgerDog;
aim_walk_animation = sArkovianBurgerDog;
hurt_animation = sWilliam_Hurt;

leg_spd = 0.06;
leg_lerp_spd = 0.7;
leg_ground_check_radius = 12;
leg_ground_check_angle_range = 90;
leg_ground_check_angle_offset = 0;

leg_anchor[0, 0] = 6;
leg_anchor[0, 1] = -12;

leg_anchor[1, 0] = 2;
leg_anchor[1, 1] = -12;

leg_anchor[2, 0] = -6;
leg_anchor[2, 1] = -12;

leg_anchor[3, 0] = -10;
leg_anchor[3, 1] = -12;

// Animation Variables
leg_draw_val = 0;

leg_draw_val_offset[0] = 0;
leg_draw_val_offset[1] = 0.1;
leg_draw_val_offset[2] = 0.35;
leg_draw_val_offset[3] = 0.45;

leg_direction[0] = 270;
leg_direction[1] = 270;
leg_direction[2] = 270;
leg_direction[3] = 270;

leg_grounded[0] = false;
leg_grounded[1] = false;
leg_grounded[2] = false;
leg_grounded[3] = false;

leg_end[0, 0] = 0;
leg_end[0, 1] = 0;
leg_end[1, 0] = 0;
leg_end[1, 1] = 0;
leg_end[2, 0] = 0;
leg_end[2, 1] = 0;
leg_end[3, 0] = 0;
leg_end[3, 1] = 0;

leg_limb[0] = instance_create_layer(x, y, layers[4], oArm);
leg_limb[1] = instance_create_layer(x, y, layers[1], oArm);
leg_limb[2] = instance_create_layer(x, y, layers[4], oArm);
leg_limb[3] = instance_create_layer(x, y, layers[1], oArm);

leg_lerp[0, 0] = x;
leg_lerp[0, 1] = y;
leg_lerp[1, 0] = x;
leg_lerp[1, 1] = y;
leg_lerp[2, 0] = x;
leg_lerp[2, 1] = y;
leg_lerp[3, 0] = x;
leg_lerp[3, 1] = y;
