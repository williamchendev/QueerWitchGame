/// @description Firearm Update
// Calculates the behaviour of the firearm object

// Stop Time Event Skip
if (game_manager.stop_time) {
	return;
}

// Inherit the parent event
event_inherited();

/// Weapon Rotation & Scaling
var temp_target_x = mouse_room_x();
var temp_target_y = mouse_room_y();

weapon_rotation = point_direction(x, y, temp_target_x, temp_target_y);
if (temp_target_x < x) {
	weapon_yscale = -1;
}
else {
	weapon_yscale = 1;
}

// Weapon Rotation
var temp_weapon_rotation = weapon_rotation + recoil_angle_shift;

// Fire Behaviour
if (mouse_check_button_pressed(mb_left)) {
	// Hitscan
	var temp_accuracy = (clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak) / 2;
	var temp_hitscan_angle = temp_weapon_rotation + random_range(-temp_accuracy, temp_accuracy);
	
	// Animation
	if (reload_sprite != noone) {
		weapon_sprite = reload_sprite;
		image_index = 0;
		image_speed = sprite_get_speed(reload_sprite);
	}
	
	if (case_sprite != noone) {
		var temp_eject_direction = point_direction(0, 0, case_eject_x * weapon_xscale, case_eject_y * weapon_yscale);
		var temp_eject_distance = point_distance(0, 0, case_eject_x * weapon_xscale, case_eject_y * weapon_yscale);
		
		var temp_eject_x = x + lengthdir_x(temp_eject_distance, temp_weapon_rotation + temp_eject_direction);
		var temp_eject_y = y + lengthdir_y(temp_eject_distance, temp_weapon_rotation + temp_eject_direction);
		
		var temp_case = instance_create_layer(temp_eject_x, temp_eject_y, layer, oBulletCase);
		temp_case.case_direction = (random_range(0, case_direction) * weapon_yscale) + 90;
		temp_case.sprite_index = case_sprite;
	}
	
	// Reset Aim
	aim = 0;
	
	// Calculate Recoil
	recoil_angle_shift += recoil_angle;
	recoil_velocity = 0;
	recoil_timer = recoil_delay;
	recoil_position_direction = -180 + random_range(-recoil_direction, recoil_direction);
	
	// Flash
	flash_timer = 0.2;
	flash_direction = temp_hitscan_angle;
}

// Firearm Behaviour
if (aiming) {
	aim = lerp(aim, 1, aim_spd * (delta_time * 0.000005));
	aim_hip_max = aim;
}
else {
	aim = lerp(aim, clamp(aim_hip_max - 0.4, 0, 1), (aim_spd * 0.7) * (delta_time * 0.000005));
}

// Flash
if (flash_timer > 0) {
	flash_timer -= (delta_time * 0.000005);
}

// Recoil
if (recoil_timer > 0) {
	recoil_timer -= (delta_time * 0.000005);
	recoil_velocity += recoil_spd * (delta_time * 0.000065);
	x += lengthdir_x(recoil_velocity, recoil_position_direction + temp_weapon_rotation) * (delta_time * 0.000065);
	y += lengthdir_y(recoil_velocity, recoil_position_direction + temp_weapon_rotation) * (delta_time * 0.000065);
	
	var temp_recoil_distance = point_distance(x_position, y_position, x, y);
	if (temp_recoil_distance > recoil_clamp) {
		x = x_position + lengthdir_x(recoil_clamp, recoil_position_direction + temp_weapon_rotation);
		y = y_position + lengthdir_y(recoil_clamp, recoil_position_direction + temp_weapon_rotation);
	}
}
else {
	recoil_angle_shift = lerp(recoil_angle_shift, 0, angle_adjust_spd * (delta_time * 0.000005));
	x = lerp(x, x_position, lerp_spd * (delta_time * 0.000005));
	y = lerp(y, y_position, lerp_spd * (delta_time * 0.000005));
}