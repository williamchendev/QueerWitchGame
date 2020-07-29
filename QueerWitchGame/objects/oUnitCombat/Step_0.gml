/// @description Unit Combat Update Event
// The combat calculations and behaviour of the Unit

// Physics & Unit Behaviour Inheritance
event_inherited();

// Limbs
for (var q = 0; q < limbs; q++) {
	limb[q].visible = false;
}

// Weapons
for (var i = 0; i < ds_list_size(inventory.weapons); i++) {
	var temp_weapon = ds_list_find_value(inventory.weapons, i);
	
	if (temp_weapon.equip) {
		// Weapon Behaviour
		if (key_select_press) {
			// Fire Weapon
			temp_weapon.attack = canmove;
			temp_weapon.ignore_id = team_id;
		}
		
		// Weapon Layer
		temp_weapon.layer = layers[3];
		
		// Aiming Behaviour
		temp_weapon.aiming = false;
		if (target_manual) {
			if (sign(target_x - x) != 0) {
				image_xscale = sign(target_x - x);
			}
			
			temp_weapon.aiming = true;
			var temp_weapon_target_angle = point_direction(x + weapon_x, y + weapon_y, target_x, target_y);
			var temp_weapon_delta_angle = angle_difference(temp_weapon.weapon_rotation, temp_weapon_target_angle);
			temp_weapon.weapon_rotation = temp_weapon.weapon_rotation - (temp_weapon_delta_angle * temp_weapon.lerp_spd * global.deltatime);
		}
		else if (target != noone) {
			if (instance_exists(target)) {
				// Aim Weapon
				if (abs(x_velocity) <= 0.1) {
					if (!platform_free(x, y + 1, platform_list)) {
						if (sign(image_xscale) == sign(target.x - x)) {
							temp_weapon.aiming = true;
							var temp_weapon_target_angle = point_direction(x + weapon_x, y + weapon_y, target.x, target.y - 24);
							var temp_weapon_delta_angle = angle_difference(temp_weapon.weapon_rotation, temp_weapon_target_angle);
							temp_weapon.weapon_rotation = temp_weapon.weapon_rotation - (temp_weapon_delta_angle * temp_weapon.lerp_spd * global.deltatime);
						}
					}
				}
			}
			else {
				// Reset Target
				target = noone;
			}
		}
		
		// Ambient Aiming
		aim_ambient_x = lerp(aim_ambient_x, x + (draw_xscale * image_xscale * 50), temp_weapon.lerp_spd * global.deltatime);
		aim_ambient_y = lerp(aim_ambient_y, y + weapon_hip_y, temp_weapon.lerp_spd * global.deltatime);
		if (!temp_weapon.aiming) {
			temp_weapon.weapon_rotation = temp_weapon.weapon_rotation - (angle_difference(temp_weapon.weapon_rotation, slope_angle + point_direction(x + weapon_x, y + weapon_y, aim_ambient_x, aim_ambient_y)) * temp_weapon.lerp_spd * global.deltatime);
		}
		
		// Move Weapon Position and Rotation
		var temp_weapon_x = weapon_hip_x;
		var temp_weapon_y = weapon_hip_y;
		if (temp_weapon.aiming) {
			temp_weapon_x = weapon_aim_x;
			temp_weapon_y = weapon_aim_y;
		}
		
		var temp_limb_aim_move_offset_x = 0;
		var temp_limb_aim_offset_y = 0;
		if (key_aim_press) {
			temp_limb_aim_offset_y = limb_aim_offset_y;
			if (x_velocity != 0) {
				temp_limb_aim_move_offset_x = sign(x_velocity) * limb_aim_move_offset_x;
			}
		}
		
		weapon_x = lerp(weapon_x, temp_weapon_x, temp_weapon.lerp_spd * global.deltatime);
		weapon_y = lerp(weapon_y, temp_weapon_y, temp_weapon.lerp_spd * global.deltatime);
		
		var temp_weapon_distance = point_distance(0, 0, (draw_xscale * image_xscale * weapon_x), (draw_yscale * image_yscale * weapon_y));
		var temp_weapon_direction = point_direction(0, 0, (draw_xscale * image_xscale * weapon_x), (draw_yscale * image_yscale * weapon_y));
		temp_weapon.x_position = x + lengthdir_x(temp_weapon_distance, temp_weapon_direction + draw_angle) - temp_limb_aim_move_offset_x;
		temp_weapon.y_position = y + lengthdir_y(temp_weapon_distance, temp_weapon_direction + draw_angle);
		
		// Establish Arm Variables
		var temp_arm_direction = 0;
		if (sign(image_xscale) < 0) {
			temp_arm_direction = 1;
			limb[0].limb_sprite = limb_sprite[0];
			limb[1].limb_sprite = limb_sprite[1];
		}
		else {
			limb[0].limb_sprite = limb_sprite[1];
			limb[1].limb_sprite = limb_sprite[0];
		}
		var temp_arm_x_offset = sign(x_velocity);
		
		// Set Arm Position Backarm
		limb[0].visible = true;
		limb[0].limb_direction = sign(image_xscale);
		
		var temp_limb_anchor_distance = point_distance(0, 0, (draw_xscale * image_xscale * limb_x[0]) + temp_arm_x_offset, (draw_yscale * image_yscale * limb_y[0]));
		var temp_limb_anchor_direction = point_direction(0, 0, (draw_xscale * image_xscale * limb_x[0]) + temp_arm_x_offset, (draw_yscale * image_yscale * limb_y[0]));
		limb[0].limb_anchor_x = x + lengthdir_x(temp_limb_anchor_distance, draw_angle + temp_limb_anchor_direction) + temp_limb_aim_move_offset_x;
		limb[0].limb_anchor_y = y + lengthdir_y(temp_limb_anchor_distance, draw_angle + temp_limb_anchor_direction) + temp_limb_aim_offset_y;
		
		var temp_limb_distance = point_distance(0, 0, temp_weapon.arm_x[0], temp_weapon.arm_y[0] * sign(image_xscale));
		var temp_limb_direction = point_direction(0, 0, temp_weapon.arm_x[0], temp_weapon.arm_y[0] * sign(image_xscale));
		
		limb[0].limb_target_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
		limb[0].limb_target_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
		
		// Set Arm Position Frontarm
		if (temp_weapon.double_handed and (limbs > 1)) {
			limb[1].visible = true;
			limb[1].limb_direction = sign(image_xscale);
			
			var temp_limb_anchor_distance = point_distance(0, 0, (draw_xscale * image_xscale * limb_x[1]) + temp_arm_x_offset, (draw_yscale * image_yscale * limb_y[0]));
			var temp_limb_anchor_direction = point_direction(0, 0, (draw_xscale * image_xscale * limb_x[1]) + temp_arm_x_offset, (draw_yscale * image_yscale * limb_y[0]));
			limb[1].limb_anchor_x = x + lengthdir_x(temp_limb_anchor_distance, draw_angle + temp_limb_anchor_direction) + temp_limb_aim_move_offset_x;
			limb[1].limb_anchor_y = y + lengthdir_y(temp_limb_anchor_distance, draw_angle + temp_limb_anchor_direction) + temp_limb_aim_offset_y;
			
			var temp_limb_distance = point_distance(0, 0, temp_weapon.arm_x[1], temp_weapon.arm_y[1] * sign(image_xscale));
			var temp_limb_direction = point_direction(0, 0, temp_weapon.arm_x[1], temp_weapon.arm_y[1] * sign(image_xscale));
		
			limb[1].limb_target_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
			limb[1].limb_target_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
		}
	}
}

// Knockout
if (knockout) {
	if (!knockout_active) {
		// Activate Knockout
		if (health_points <= 0) {
			knockout_active = true;
			
			// Disable Movement
			game_manager.time_spd = 0.07;
			for (var u = 0; u < instance_number(oUnitCombat); u++) {
				var temp_combat_unit = instance_find(oUnitCombat, u);
				temp_combat_unit.canmove = false;
			}
			if (!instance_exists(oKnockout)) {
				instance_create_depth(x, y, -6000, oKnockout);
			}
		}
	}
	else {
		knockout_timer -= (global.realdeltatime / 60);
		if (knockout_timer <= 0) {
			knockout = false;
			knockout_active = false;
			game_manager.time_spd = 1;
			for (var u = 0; u < instance_number(oUnitCombat); u++) {
				var temp_combat_unit = instance_find(oUnitCombat, u);
				temp_combat_unit.canmove = true;
			}
			if (instance_exists(oKnockout)) {
				instance_destroy(oKnockout);
			}
		}
	}
}