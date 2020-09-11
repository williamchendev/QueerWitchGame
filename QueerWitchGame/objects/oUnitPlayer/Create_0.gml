/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Animation Settings
idle_animation = sWilliamDS_Idle;
walk_animation = sWilliamDS_Run;
jump_animation = sWilliamDS_Jump;

knockout = true;

// Behaviour Settings
command = false;

command_time = false;
command_time_mod = 0.25;
command_lerp_time = false;

inventory_show = false;

// AI Settings
ai_behaviour = false;

// Inventory Settings
inventory_x_offset = 32;
inventory_lerp_spd = 0.08;

// Camera Settings
camera_x = x - (game_manager.camera_width / 2);
camera_y = y - (game_manager.camera_height / 2);

camera_follow = true;
camera_follow_spd = 0.03;
camera_y_offset = -42;

camera_moving_x_offset = 120;
camera_lockon_bounds = -64;
camera_horizontal_spacing = 120;
camera_vertical_spacing = 64;

// Combat Settings
health_points = 3;
max_health_points = 3;

// Combat Variables
targets = noone;
targets_index = -1;

// Debug
player_input = true;

var temp_camera = view_camera[0];
camera_x = camera_get_view_x(temp_camera);
camera_y = camera_get_view_y(temp_camera);

team_id = "player";

addItemInventory(inventory, 5);
addItemInventory(inventory, 7, 6);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;
inventory.debug = true;