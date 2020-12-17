/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Inventory
addItemInventory(inventory, 9);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;

// Enemy Settings
health_show = true;
health_points = 9;
max_health_points = 9;

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

idle_animation = sWilliamDS_Heavy_Idle;
walk_animation = sWilliamDS_Heavy_Run;
jump_animation = sWilliamDS_Heavy_Jump;
aim_animation = sWilliamDS_Heavy_Aim;
aim_walk_animation = sWilliamDS_Heavy_AimWalk;
hurt_animation = sWilliam_Hurt;

// Ragdoll Settings
ragdoll = true;
ragdoll_head_sprite = sWilliamDS_Heavy_Head;
ragdoll_arm_left_sprite = sWilliamDS_Heavy_Arms;
ragdoll_arm_right_sprite = sWilliamDS_Heavy_Arms;
ragdoll_chest_top_sprite = sWilliamDS_Heavy_ChestTop;
ragdoll_chest_bot_sprite = sWilliamDS_Heavy_ChestBot;
ragdoll_leg_left_sprite = sWilliamDS_Heavy_LeftLeg;
ragdoll_leg_right_sprite = sWilliamDS_Heavy_RightLeg;

// Weapon Settings
weapon_hip_x = -1;
weapon_hip_y = -30;

weapon_aim_x = 5;
weapon_aim_y = -38;

inventory_x = -6;
inventory_y = -27;

// Limb Settings
limbs = 2;

limb_x[0] = -6;
limb_y[0] = -37;

limb_x[1] = 5;
limb_y[1] = -37;

limb_aim_move_offset_x = -3;
limb_aim_offset_y = 2;

limb_sprite[0] = sWilliamDS_Heavy_Arms;  // Right Arm
limb_sprite[1] = sWilliamDS_Heavy_Arms;  // Left Arm