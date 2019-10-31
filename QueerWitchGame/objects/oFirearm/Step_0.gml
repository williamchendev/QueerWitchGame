/// @description Firearm Update
// Calculates the behaviour of the firearm object

// Inherit the parent event
event_inherited();

/// Weapon Position
x = lerp(x, x_position, move_spd * global.deltatime);
y = lerp(y, y_position, move_spd * global.deltatime);

var temp_x = x + recoil_offset_x;
var temp_y = y + recoil_offset_y;

/// Weapon Rotation & Scaling
var temp_target_x = mouse_room_x();
var temp_target_y = mouse_room_y();
weapon_rotation = point_direction(temp_x, temp_y, temp_target_x, temp_target_y);

if (temp_x + lengthdir_x(5, weapon_rotation) < temp_x) {
	weapon_yscale = -1;
}
else {
	weapon_yscale = 1;
}

// Weapon Rotation
var temp_weapon_rotation = weapon_rotation + recoil_angle_shift;

// Set Fire Mode Behaviour
if (mouse_check_button_pressed(mb_left)) {
	bursts = max(burst, 1);
	bursts_timer = 0;
}

// Firearm Behaviour
if (aiming) {
	aim = lerp(aim, 1, aim_spd * global.deltatime);
	var temp_accuracy = clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak;
	if (temp_accuracy <= accuracy_peak + 0.1) {
		aim = 1;
	}
	aim_hip_max = aim;
}
else {
	aim = lerp(aim, clamp(aim_hip_max - 0.4, 0, 1), (aim_spd * 0.7) * global.deltatime);
}

// Fire Behaviour
if (bursts > 0) {
	bursts_timer -= global.deltatime;
	if (bursts_timer <= 0) {
		// Burst Behaviour
		bursts--;
		bursts_timer = burst_delay
	
		// Projectiles
		for (var i = 0; i < projectiles; i++) {
			// Hitscan
			var temp_accuracy = (clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak) / 2;
			var temp_hitscan_angle = temp_weapon_rotation + random_range(-temp_accuracy, temp_accuracy);
			
			// Flash
			ds_list_add(flash_direction, temp_hitscan_angle);
			ds_list_add(flash_timer, flash_delay);
			
			if (muzzle_flash_sprite != noone) {
				//muzzle_flash_index = random_range(0, sprite_get_number(muzzle_flash_sprite));
				ds_list_add(flash_imageindex, random_range(0, sprite_get_number(muzzle_flash_sprite)));
			}
			
			// Calculate Flash Position
			var temp_muzzle_direction = point_direction(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);
			var temp_muzzle_distance = point_distance(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale) - 2;

			var temp_muzzle_x = temp_x + lengthdir_x(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
			var temp_muzzle_y = temp_y + lengthdir_y(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
			
			ds_list_add(flash_xposition, temp_muzzle_x);
			ds_list_add(flash_yposition, temp_muzzle_y);
			
			// Bullet Cases
			if (case_sprite != noone) {
				bullet_cases++;
			}
		}
		
		// Burst End
		if (bursts <= 0) {
			// Reset Aim
			aim = 0;
	
			// Calculate Recoil
			recoil_angle_shift += recoil_angle * weapon_yscale;
			recoil_velocity = 0;
			recoil_timer = recoil_delay;
			recoil_position_direction = -180 + random_range(-recoil_direction, recoil_direction);
		}
	
		// Animation
		if (reload_sprite != noone) {
			weapon_sprite = reload_sprite;
			image_index = 0;
			image_speed = sprite_get_speed(reload_sprite);
		}
	}
}

// Flash
for (var f = ds_list_size(flash_timer) - 1; f >= 0; f--) {
	var temp_flash_timer = ds_list_find_value(flash_timer, f);
	temp_flash_timer -= global.deltatime;
	if (temp_flash_timer <= 0) {
		ds_list_delete(flash_timer, f);
		ds_list_delete(flash_direction, f);
		ds_list_delete(flash_xposition, f);
		ds_list_delete(flash_yposition, f);
		ds_list_delete(flash_imageindex, f);
		continue;
	}
	ds_list_set(flash_timer, f, temp_flash_timer);
}

// Recoil
if (recoil_timer > 0) {
	recoil_timer -= global.deltatime;
	recoil_velocity += recoil_spd * global.deltatime;
	recoil_offset_x += lengthdir_x(recoil_velocity, recoil_position_direction + temp_weapon_rotation) * global.deltatime;
	recoil_offset_y += lengthdir_y(recoil_velocity, recoil_position_direction + temp_weapon_rotation) * global.deltatime;
	
	var temp_recoil_distance = point_distance(recoil_offset_x, recoil_offset_y, 0, 0);
	if (temp_recoil_distance > recoil_clamp) {
		recoil_offset_x = lengthdir_x(recoil_clamp, recoil_position_direction + temp_weapon_rotation);
		recoil_offset_y = lengthdir_y(recoil_clamp, recoil_position_direction + temp_weapon_rotation);
	}
}
else {
	recoil_angle_shift = lerp(recoil_angle_shift, 0, angle_adjust_spd * global.deltatime);
	recoil_offset_x = lerp(recoil_offset_x, 0, lerp_spd * global.deltatime);
	recoil_offset_y = lerp(recoil_offset_y, 0, lerp_spd * global.deltatime);
}

// Bullet Cases
if (bullet_cases != 0) {
	for (var c = 0; c < bullet_cases; c++) {
		var temp_eject_direction = point_direction(0, 0, case_eject_x * weapon_xscale, case_eject_y * weapon_yscale);
		var temp_eject_distance = point_distance(0, 0, case_eject_x * weapon_xscale, case_eject_y * weapon_yscale);
		
		var temp_eject_x = x + recoil_offset_x + lengthdir_x(temp_eject_distance, temp_weapon_rotation + temp_eject_direction);
		var temp_eject_y = y + recoil_offset_y + lengthdir_y(temp_eject_distance, temp_weapon_rotation + temp_eject_direction);
		
		var temp_case = instance_create_layer(temp_eject_x, temp_eject_y, layer, oBulletCase);
		temp_case.case_direction = (random_range(0, case_direction) * weapon_yscale) + 90;
		temp_case.sprite_index = case_sprite;
		temp_case.image_xscale = weapon_yscale;
	}
	bullet_cases = 0;
}