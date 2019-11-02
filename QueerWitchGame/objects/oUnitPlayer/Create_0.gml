/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Behaviour
command = false;

command_lerp_time = false;

// Debug
player_input = true;

weapons[0] = instance_create_layer(x, y, layers[3], oGun_M14);
weapons[0].equip = true;