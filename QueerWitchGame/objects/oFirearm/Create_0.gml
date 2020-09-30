/// @description Firearm Initialization
// Creates the variables for the Firearm Object

// Inherit the parent event
event_inherited();

// Weapon Settings
weapon_ammo_id = 7;

bullets = 0;
bullets_max = 5;

// Sprite Settings
weapon_sprite = sMarinda308;
case_sprite = s308Case;
muzzle_flash_sprite = s308MuzzleFlash;

image_speed = 0;
image_index = 1;

// Bullet Settings
projectiles = 1;

burst = 0;
burst_delay = 0.1;

flash_delay = 7;

// Position Settings
muzzle_x = 28;
muzzle_y = -2;

reload_x = 5;
reload_y = 0;
reload_offset_y = 5;

case_eject_x = 1;
case_eject_y = -1;
case_direction = 30;

// Reload Settings
magazine_obj = noone;

// Arm Settings
double_handed = false;

arm_x = noone;
arm_y = noone;
arm_x[0] = 0;
arm_y[0] = 0;

// Behaviour Settings
move_spd = 0.4;

aim_spd = 0.04;
lerp_spd = 0.12;
angle_adjust_spd = 0.1;

recoil_spd = 0.66;
recoil_angle = 4;
recoil_direction = 6;
recoil_delay = 4.6;
recoil_clamp = 16;

click = true;

// Aiming Settings
sniper = true;

range = 1000;
accuracy = 120;
accuracy_peak = 0.1;

// Firearm Variables
x_position = x;
y_position = y;

recoil_offset_x = 0;
recoil_offset_y = 0;

aim_hip_max = 0;

recoil_timer = 0;
recoil_velocity = 0;
recoil_angle_shift = 0;
recoil_position_direction = 0;

bursts = 0;
bursts_timer = 0;
bullet_cases = 0;

ignore_id = "unassigned";

// Draw Variables
//muzzle_flash_index = 0;

flash_timer = ds_list_create();
flash_length = ds_list_create();
flash_direction = ds_list_create();
flash_xposition = ds_list_create();
flash_yposition = ds_list_create();

flash_imageindex = ds_list_create();

hit_effect_index = -1;
hit_effect_offset = 0;
hit_effect_xscale = 1;
hit_effect_yscale = 1;
hit_effect_sign = 1;