/// @description FAL FN Init

// Inherit the parent event
event_inherited();

// Animation Settings
weapon_sprite = sFAL;

// Weapon Settings
weapon_ammo_id = 7;

bullets = 0;
bullets_max = 15;

// Combat Settings
damage = 2;
material_damage_sprite = sMatDmg_Small_1;

// Bullet Settings
projectiles = 1;

burst = 3;
burst_delay = 1;

flash_delay = 7;

// Position Settings
muzzle_x = 29;
muzzle_y = -1;

// Reload Settings
magazine_obj = oGun_FAL_Mag;

reload_x = 10;
reload_y = 2;

reload_offset_y = 6;

// Arm Settings
double_handed = true;

arm_x[1] = 19;
arm_y[1] = 0;

arm_x[0] = 6;
arm_y[0] = 1;

// Bullet Case Settings
case_sprite = s308Case;
case_eject_x = 1;
case_eject_y = -1;
case_direction = 40;

// Behaviour Settings
move_spd = 0.4;

aim_spd = 0.06;
lerp_spd = 0.14;
angle_adjust_spd = 0.35;

recoil_spd = 0.6;
recoil_angle = 10;
recoil_direction = 6;
recoil_delay = 8;
recoil_clamp = 8;

click = true;

// Aiming Settings
sniper = false;

accuracy = 35;
accuracy_peak = 6;

close_range_hit_chance = 1.0;
mid_range_hit_chance = 1.0;
far_range_hit_chance = 1.0;
sniper_range_hit_chance = 1.0;