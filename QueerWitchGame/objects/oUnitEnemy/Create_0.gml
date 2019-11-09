/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

weapons[0] = instance_create_layer(x, y, layers[3], oGun_M14);
weapons[0].equip = true;

target = oUnitPlayer;

team_id = "enemy";

debug_timer = irandom_range(120, 480);