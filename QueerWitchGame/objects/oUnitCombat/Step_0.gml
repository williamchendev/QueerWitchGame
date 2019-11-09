/// @description Unit Combat Update Event
// The combat calculations and behaviour of the Unit

// Physics & Unit Behaviour Inheritance
event_inherited();

// Limbs
for (var q = 0; q < limbs; q++) {
	limb[q].visible = false;
}

// Weapons
for (var i = 0; i < array_length_1d(weapons); i++) {
	if (weapons[i].equip) {
		// Weapon Behaviour
		if (key_select_press) {
			// Fire Weapon
			weapons[i].attack = canmove;
			weapons[i].ignore_id = team_id;
		}
		
		// Aiming Behaviour
		weapons[i].aiming = false;
		if (target != noone) {
			if (instance_exists(target)) {
				// Aim Weapon
				if (abs(x_velocity) <= 0.1) {
					if (!platform_free(x, y + 1, platform_list)) {
						if (sign(image_xscale) == sign(target.x - x)) {
							weapons[i].aiming = true;
							var temp_weapon_target_angle = point_direction(x + weapon_x, y + weapon_y, target.x, target.y - 24);
							var temp_weapon_delta_angle = angle_difference(weapons[i].weapon_rotation, temp_weapon_target_angle);
							weapons[i].weapon_rotation = weapons[i].weapon_rotation - (temp_weapon_delta_angle * weapons[i].lerp_spd * global.deltatime);
						}
					}
				}
			}
			else {
				// Reset Target
				target = noone;
			}
		}
		
		if (!weapons[i].aiming) {
			// Ambient Aiming
			aim_ambient_x = lerp(aim_ambient_x, x + (draw_xscale * image_xscale * 50), weapons[i].lerp_spd * global.deltatime);
			aim_ambient_y = lerp(aim_ambient_y, y + weapon_hip_y, weapons[i].lerp_spd * global.deltatime);
			weapons[i].weapon_rotation = weapons[i].weapon_rotation - (angle_difference(weapons[i].weapon_rotation, point_direction(x + weapon_x, y + weapon_y, aim_ambient_x, aim_ambient_y)) * weapons[i].lerp_spd * global.deltatime);
		}
		
		// Move Weapon Position and Rotation
		var temp_weapon_x = weapon_hip_x;
		var temp_weapon_y = weapon_hip_y;
		if (weapons[i].aiming) {
			temp_weapon_x = weapon_aim_x;
			temp_weapon_y = weapon_aim_y;
		}
		
		weapon_x = lerp(weapon_x, temp_weapon_x, weapons[i].lerp_spd * global.deltatime);
		weapon_y = lerp(weapon_y, temp_weapon_y, weapons[i].lerp_spd * global.deltatime);
		
		weapons[i].x_position = x + (draw_xscale * image_xscale * weapon_x);
		weapons[i].y_position = y + (draw_yscale * image_yscale * weapon_y);
		
		// Establish Arm Variables
		var temp_arm_direction = 0;
		if (sign(image_xscale) < 0) {
			temp_arm_direction = 1;
		}
		
		// Set Arm Position Backarm
		limb[0].visible = true;
		limb[0].limb_direction = sign(image_xscale);
		
		limb[0].limb_anchor_x = x + (draw_xscale * image_xscale * limb_x[0]);
		limb[0].limb_anchor_y = y + (draw_yscale * image_yscale * limb_y[0]);
		
		var temp_limb_distance = point_distance(0, 0, weapons[i].arm_x[0], weapons[i].arm_y[0] * sign(image_xscale));
		var temp_limb_direction = point_direction(0, 0, weapons[i].arm_x[0], weapons[i].arm_y[0] * sign(image_xscale));
		
		limb[0].limb_target_x = weapons[i].x + weapons[i].recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
		limb[0].limb_target_y = weapons[i].y + weapons[i].recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
		
		// Set Arm Position Frontarm
		if (weapons[i].double_handed and (limbs > 1)) {
			limb[1].visible = true;
			limb[1].limb_direction = sign(image_xscale);
			
			limb[1].limb_anchor_x = x + (draw_xscale * image_xscale * limb_x[1]);
			limb[1].limb_anchor_y = y + (draw_yscale * image_yscale * limb_y[1]);
			
			var temp_limb_distance = point_distance(0, 0, weapons[i].arm_x[1], weapons[i].arm_y[1] * sign(image_xscale));
			var temp_limb_direction = point_direction(0, 0, weapons[i].arm_x[1], weapons[i].arm_y[1] * sign(image_xscale));
		
			limb[1].limb_target_x = weapons[i].x + weapons[i].recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
			limb[1].limb_target_y = weapons[i].y + weapons[i].recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
		}
	}
}