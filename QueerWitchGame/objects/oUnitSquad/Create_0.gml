/// @description Squad Unit Initialization
// The variable and settings initialization for the Player Unit

// Inherit the parent event
event_inherited();

// Animation Settings
idle_animation = sWilliamDS_Idle;
walk_animation = sWilliamDS_Run;
jump_animation = sWilliamDS_Jump;

knockout = true;

squad_outline_color = make_color_rgb(212, 175, 55);

// Command Settings
command = false;

command_time = false;
command_time_mod = 0.25;
command_lerp_time = false;

// Player Settings
player_input = false;

unit_select = noone;
unit_select_hover = noone;
unit_select_hitbox_offset = 8;

// AI Settings
ai_behaviour = true;
ai_command = true;
ai_hunt = false;
ai_follow_aim = true;

alert = 1;
alert_spd = 0;

// Combat Settings
health_points = 3;
max_health_points = 3;

team_id = "player";

// Inventory Settings
inventory_show = false;

inventory_x_offset = 32;
inventory_lerp_spd = 0.08;

// Camera Settings
camera_x = x - (game_manager.camera_width / 2);
camera_y = y - (game_manager.camera_height / 2);

camera_follow = false;
camera_follow_spd = 0.03;
camera_y_offset = -42;

camera_moving_x_offset = 120;
camera_lockon_bounds = -64;
camera_horizontal_spacing = 120;
camera_vertical_spacing = 64;

// Cursor Settings
cursor_x = 0;
cursor_y = 0;

old_fire_press = false;
old_aim_press = false;

// Debug
var temp_camera = view_camera[0];
camera_x = camera_get_view_x(temp_camera);
camera_y = camera_get_view_y(temp_camera);

addItemInventory(inventory, 8);
addItemInventory(inventory, 7, 6);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;
inventory.debug = true;