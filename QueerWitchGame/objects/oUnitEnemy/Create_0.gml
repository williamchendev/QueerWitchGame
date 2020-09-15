/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

addItemInventory(inventory, 5);
addItemInventory(inventory, 7, 6);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;

team_id = "enemy";

// Debug
idle_animation = sWilliamDS_Idle;
walk_animation = sWilliamDS_Run;
jump_animation = sWilliamDS_Jump;

limb[0].limb_sprite = sWilliamDS_Arms;
limb[1].limb_sprite = sWilliamDS_Arms;

health_points = 1;
max_health_points = 1;
health_show = false;