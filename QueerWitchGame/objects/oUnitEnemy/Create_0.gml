/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

team_id = "enemy";

// Debug
idle_animation = sWilliamDS_Idle;
walk_animation = sWilliamDS_Run;
jump_animation = sWilliamDS_Jump;

limb_sprite[0] = sWilliamDS_Arms;
limb_sprite[1] = sWilliam_Arms;

health_points = 3;
max_health_points = 3;
health_show = false;

// Death Dialogue Settings
death_dialogue = true;
death_dialogue_chance = 0.4;
death_dialogue_text = noone;

// Inventory
addItemInventory(inventory, 7, 10);