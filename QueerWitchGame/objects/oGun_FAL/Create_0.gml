/// @description FAL FN Init

// Inherit the parent event
event_inherited();

// Animation Settings
weapon_sprite = sFAL;

// Bullet Settings
projectiles = 1;

burst = 3;
burst_delay = 3;

flash_delay = 7;

// Position Settings
muzzle_x = 26;
muzzle_y = -2;

// Arm Settings
double_handed = true;

arm_x[0] = 16;
arm_y[0] = -1;

arm_x[1] = 3;
arm_y[1] = 0;

// Bullet Case Settings
case_sprite = s308Case;
case_eject_x = 1;
case_eject_y = -2;
case_direction = 40;

// Behaviour Settings
move_spd = 0.4;

aim_spd = 0.06;
lerp_spd = 0.07;
angle_adjust_spd = 0.35;

recoil_spd = 0.6;
recoil_angle = 10;
recoil_direction = 6;
recoil_delay = 8;
recoil_clamp = 8;

click = true;

// Aiming Settings
sniper = false;

range = 900;
accuracy = 35;
accuracy_peak = 6;