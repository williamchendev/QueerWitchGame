/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

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

// Beahviour Settings
canmove = true;

team_id = "player";

health_show = true;
health_points = 12;
max_health_points = 12;

// Animation Settings
idle_animation = sWilliamDS_Heavy_Idle;
walk_animation = sWilliamDS_Heavy_Run;
jump_animation = sWilliamDS_Heavy_Jump;
aim_animation = sWilliamDS_Heavy_Aim;
aim_walk_animation = sWilliamDS_Heavy_AimWalk;
hurt_animation = sWilliam_Hurt;

animation_spd = 0.18;

action_spd = 0.20;

squash_stretch = 0.6;
scale_reset_spd = 0.15;

stats_y_offset = 8;

knockout = true;

// Ragdoll Settings
ragdoll = true;
ragdoll_head_sprite = sWilliamDS_Heavy_Head;
ragdoll_arm_left_sprite = sWilliamDS_Heavy_Arms;
ragdoll_arm_right_sprite = sWilliamDS_Heavy_Arms;
ragdoll_chest_top_sprite = sWilliamDS_Heavy_ChestTop;
ragdoll_chest_bot_sprite = sWilliamDS_Heavy_ChestBot;
ragdoll_leg_left_sprite = sWilliamDS_Heavy_LeftLeg;
ragdoll_leg_right_sprite = sWilliamDS_Heavy_RightLeg;

// Sight Settings
sight = true;

alert = 0;
alert_spd = 0.005;
alert_threshold = 0.8;

sight_origin_x = 0;
sight_origin_y = -40;

sight_unalert_radius = 280;
sight_unalert_arc = 15;

sight_alert_radius = 340;
sight_alert_arc = 30;

// Pathfinding Settings
path_x_delta_tolerance = 3;
path_increment_index_radius = 5;

// Combat Variables
target_x = 0;
target_y = 0;
targeting = false;

target_aim_threshold = 0.85;

// Squad Variables
squad_aim = false;
squad_key_fire_press = false;
squad_key_aim_press = false;

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

// Inventory Settings
addItemInventory(inventory, 6);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;

// Player Settings
player_input = true;
ai_behaviour = false;
camera_follow = true;

// Crunch Settings
crunch_weapon_fire_delay = 0.6;
crunch_weapon_move_spd = 0.6;
crunch_weapon_move_range = 4;

// Crunch Variables
crunch = false;
crunch_x = 0;
crunch_y = 0;
crunch_bursts = 0;
crunch_weapon_move_timer = 0;