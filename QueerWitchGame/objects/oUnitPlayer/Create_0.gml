/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Player Settings
player_input = true;
ai_behaviour = false;
camera_follow = true;

// Debug
var temp_song = ds_list_find_value(inventory.weapons, 0);
temp_song.equip = false;