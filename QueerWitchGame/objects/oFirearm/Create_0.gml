/// @description Firearm Initialization
// Creates the variables for the Firearm Object

// Inherit the parent event
event_inherited();

// Animation Settings
weapon_sprite = sMarinda308;
regular_sprite = sMarinda308;
reload_sprite = sMarinda308_Reload;
image_speed = sprite_get_speed(weapon_sprite);

// Bullet Case
case_sprite = s308Case;
case_eject_x = 0;
case_eject_y = 4;
case_direction = 30;

// Position Settings
muzzle_x = 28;
muzzle_y = -2;

// Behaviour Settings
lerp_spd = 0.8;
aim_spd = 0.2;
angle_adjust_spd = 1;

recoil_spd = 0.8;
recoil_angle = 2;
recoil_direction = 6;
recoil_delay = 0.3;
recoil_clamp = 16;

// Aiming Settings
range = 1000;
accuracy = 45;
accuracy_peak = 1;

// Firearm Variables
x_position = x;
y_position = y;

aim_hip_max = 0;

recoil_timer = 0;
recoil_velocity = 0;
recoil_angle_shift = 0;
recoil_position_direction = 0;

// Draw Variables
flash_timer = 0;
flash_direction = 0;
