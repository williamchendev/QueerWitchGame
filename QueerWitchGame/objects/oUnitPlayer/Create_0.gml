/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Behaviour
command = false;

command_time = false;
command_time_mod = 0.25;
command_lerp_time = false;

camera_follow = true;
camera_follow_spd = 0.05;
camera_y_offset = -42;

// Combat
targets = noone;
targets_index = -1;

health_points = 100;
max_health_points = 100;

// Debug
player_input = true;

var temp_camera = view_camera[0];
camera_x = camera_get_view_x(temp_camera);
camera_y = camera_get_view_y(temp_camera);

team_id = "player";

weapons[0] = instance_create_layer(x, y, layers[3], oGun_M14);
weapons[0].equip = true;