/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

// Animation Settings
weapon_sprite = sFAL;
regular_sprite = sFAL;
reload_sprite = noone;
image_speed = sprite_get_speed(weapon_sprite);

// Bullet Settings
projectiles = 1;

burst = 3;
burst_delay = 0.2;

flash_delay = 0.6;

// Bullet Case Settings
case_sprite = s308Case;
case_eject_x = 1;
case_eject_y = -2;
case_direction = 40;

// Position Settings
muzzle_x = 26;
muzzle_y = -2;

// Behaviour Settings
lerp_spd = 0.8;
aim_spd = 0.5;
angle_adjust_spd = 1.4;

recoil_spd = 1;
recoil_angle = 12;
recoil_direction = 6;
recoil_delay = 0.4;
recoil_clamp = 16;

// Aiming Settings
sniper = false;

range = 900;
accuracy = 35;
accuracy_peak = 6;