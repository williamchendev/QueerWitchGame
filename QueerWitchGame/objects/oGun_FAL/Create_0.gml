/// @description FAL FN Init

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
burst_delay = 3;

flash_delay = 7;

// Position Settings
muzzle_x = 26;
muzzle_y = -2;

double_handed = true;

arm_x[0] = 11;
arm_y[0] = 0;

arm_x[1] = 2;
arm_y[1] = 1;

// Bullet Case Settings
case_sprite = s308Case;
case_eject_x = 1;
case_eject_y = -2;
case_direction = 40;

// Behaviour Settings
aim_spd = 0.06;
lerp_spd = 0.07;
angle_adjust_spd = 0.35;

recoil_spd = 0.6;
recoil_angle = 10;
recoil_direction = 6;
recoil_delay = 8;
recoil_clamp = 14;

// Aiming Settings
sniper = false;

range = 900;
accuracy = 35;
accuracy_peak = 6;