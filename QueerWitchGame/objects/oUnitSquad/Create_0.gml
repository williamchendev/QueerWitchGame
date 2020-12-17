/// @description Squad Unit Initialization
// The variable and settings initialization for the Player Unit

// Inherit the parent event
event_inherited();

// Animation Settings
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

alert = 1;
alert_spd = 0;

// Combat Settings
can_die = true;

health_points = 3;
max_health_points = 3;
health_show = false;

team_id = "player";

// Inventory Settings
inventory_show = false;

inventory_x_offset = 32;
inventory_lerp_spd = 0.08;

// Camera Settings
camera_x = x - (game_manager.camera_width / 2);
camera_y = y - (game_manager.camera_height / 2);

camera_follow = false;
camera_follow_spd = 0.05;
camera_y_offset = -42;

camera_moving_x_offset = 120;
camera_lockon_bounds = -64;
camera_horizontal_spacing = 120;
camera_vertical_spacing = 64;

camera_lock = false;
camera_lock_x = 0;
camera_lock_y = 0;

camera_room_clamp_x = false;
camera_room_clamp_y = false;

camera_screen_shake = false;
camera_screen_shake_spd = 0.8;
camera_screen_shake_lrg = false;
camera_screen_shake_sml_range = 16;
camera_screen_shake_lrg_range = 28;
camera_screen_shake_reset_spd = 0.3;

// Cursor Settings
cursor_x = 0;
cursor_y = 0;

old_fire_press = false;
old_aim_press = false;

// Camera Variables
camera_screen_shake_x = 0;
camera_screen_shake_y = 0;
camera_screen_shake_timer = 0;

// Debug
var temp_camera = view_camera[0];
camera_x = camera_get_view_x(temp_camera);
camera_y = camera_get_view_y(temp_camera);

camera_debug_gif_mode = false;

//addItemInventory(inventory, 8);
addItemInventory(inventory, 7, 32);
//var temp_weapon = ds_list_find_value(inventory.weapons, 0);
//temp_weapon.equip = true;
//inventory.debug = true;