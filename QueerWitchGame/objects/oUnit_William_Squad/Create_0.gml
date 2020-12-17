/// @description Insert description here
// You can write your code in this editor

event_inherited();

// Animation Settings
idle_animation = sWilliam_Idle;
walk_animation = sWilliam_Run;
jump_animation = sWilliam_Jump;
aim_animation = sWilliam_Aim;
aim_walk_animation = sWilliam_Aim_Walk;
hurt_animation = sWilliam_Hurt;

limb_sprite[0] = sWilliam_Arms;
limb_sprite[1] = sWilliam_Arms;

// Ragdoll Settings
ragdoll = true;
ragdoll_head_sprite = sWilliam_Head;
ragdoll_arm_left_sprite = sWilliam_Arms;
ragdoll_arm_right_sprite = sWilliam_Arms;
ragdoll_chest_top_sprite = sWilliamDS_ChestTop;
ragdoll_chest_bot_sprite = sWilliamDS_ChestBot;
ragdoll_leg_left_sprite = sWilliamDS_LeftLeg;
ragdoll_leg_right_sprite = sWilliamDS_RightLeg;

// Physics Settings
spd = 4; // Running Speed
walk_spd = 2; // Walk Speed

jump_spd = 2; // Jumping Speed
double_jump_spd = 3.6; // Double Jumping Seed
hold_jump_spd = 0.45; // Added Jump Speed when the Jump Button is held
jump_decay = 0.81; // Decay of the Jumping Upwards Velocity

grav_spd = 0.028; // Force of Downward Gravity
grav_multiplier = 0.97; // Dampening Multiplyer of the Downward Velocity (Makes gravity smoother)
max_grav_spd = 4; // Max Speed of Unit's Downward Velocity

slope_tolerance = 3; // Tolerance for walking up slopes in pixels
slope_angle_lerp_spd = 0.1; // Speed to lerp the angle to the slope the player is standing on