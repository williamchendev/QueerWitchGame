/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Health Settings
health_points = 3;
max_health_points = 3;
health_show = false;

// Inventory Settings
addItemInventory(inventory, 8);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;