/// @description M14 Init

// Inherit the parent event
event_inherited();

// Sprite Settings
weapon_sprite = sMarinda308;
regular_sprite = sMarinda308;
reload_sprite = sMarinda308_Reload;
image_speed = sprite_get_speed(weapon_sprite);

// Bullet Settings
projectiles = 1;

burst = 0;
burst_delay = 0.1;

flash_delay = 7;

// Position Settings
muzzle_x = 28;
muzzle_y = -2;

double_handed = true;

arm_x[0] = 13;
arm_y[0] = 0;

arm_x[1] = 2;
arm_y[1] = 1;

// Bullet Case Settings
case_sprite = s308Case;
case_eject_x = 1;
case_eject_y = -1;
case_direction = 30;

// Behaviour Settings
aim_spd = 0.04;
lerp_spd = 0.12;
angle_adjust_spd = 0.1;

recoil_spd = 0.66;
recoil_angle = 8;
recoil_direction = 6;
recoil_delay = 4.6;
recoil_clamp = 6;

// Aiming Settings
sniper = true;

range = 1000;
accuracy = 40;
accuracy_peak = 1;