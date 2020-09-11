/// @description Unit Combat Update Event
// The combat calculations and behaviour of the Unit

// Physics, Pathfinding, & Unit Behaviour Inheritance
event_inherited();

// Limbs
if (limb[0] != noone) {
	arm_right_angle_1 = limb[0].angle_1;
	arm_right_angle_2 = limb[0].angle_2;
}
if (limb[1] != noone) {
	arm_left_angle_1 = limb[1].angle_1;
	arm_left_angle_2 = limb[1].angle_2;
}

for (var q = 0; q < limbs; q++) {
	limb[q].visible = false;
}

// Weapons
for (var i = 0; i < ds_list_size(inventory.weapons); i++) {
	var temp_weapon = ds_list_find_value(inventory.weapons, i);
	
	if (temp_weapon.equip) {
		// AI Behaviour
		if (ai_behaviour) {
			key_reload_press = false;
			if (temp_weapon.bullets <= 0) {
				key_reload_press = true;
			}
			
			target_manual = false;
			if (sight_unit_nearest != noone) {
				target_manual = true;
				
				var temp_unit_height = sight_unit_nearest.hitbox_right_bottom_y_offset - sight_unit_nearest.hitbox_left_top_y_offset;
				target_x = sight_unit_nearest.x;
				target_y = sight_unit_nearest.y - (temp_unit_height / 2);
			}
		}
		
		// Weapon Behaviour
		if (!reload) {
			if (key_select_press) {
				// Fire Weapon
				temp_weapon.attack = canmove;
				temp_weapon.ignore_id = team_id;
			}
			else if (key_reload_press) {
				// Reload Weapon
				if (object_is_ancestor(temp_weapon.object_index, oFirearm)) {
					var temp_ammo = countItemInventory(inventory, temp_weapon.weapon_ammo_id);
					if (temp_ammo > 0) {
						// Set Variables
						reload = true;
						action = "reload";
						action_index = 0;
						action_timer = 30 / (action_spd / 0.15);
						action_target_x = limb[0].limb_target_x;
						action_target_y = limb[0].limb_target_y;
						
						// Set Gun Reload Animation
						if (temp_weapon.image_index == 0) {
							if (temp_weapon.magazine_obj != noone) {
								var temp_mag_distance = point_distance(0, 0, temp_weapon.reload_x, temp_weapon.reload_y * sign(image_xscale));
								var temp_mag_direction = point_direction(0, 0, temp_weapon.reload_x, temp_weapon.reload_y * sign(image_xscale));
								var temp_mag_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_mag_distance, temp_mag_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
								var temp_mag_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_mag_distance, temp_mag_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
								var temp_mag = instance_create_layer(temp_mag_x, temp_mag_y, temp_weapon.layer, temp_weapon.magazine_obj);
								with (temp_mag) {
									if (!place_free(temp_mag_x + sign(other.image_xscale * (sprite_get_bbox_right(sprite_index) - sprite_get_xoffset(sprite_index))), temp_mag_y)) {
										instance_destroy();
									}
									else {
										physics_apply_angular_impulse(random_range(-5, 5));
									}
								}
								temp_weapon.image_index = 1;
							}
						}
					}
				}
			}
		}
		else {
			// Reload Weapon
			/*
			if (object_is_ancestor(temp_weapon.object_index, oFirearm)) {
				var temp_ammo = countItemInventory(inventory, temp_weapon.weapon_ammo_id);
				if (temp_ammo > 0) {
					reload = true;
					var temp_ammo_reload = min(temp_ammo, temp_weapon.bullets_max);
					temp_weapon.bullets = temp_ammo_reload;
					removeItemInventory(inventory, temp_weapon.weapon_ammo_id, temp_ammo_reload)
				}
			}
			*/
		}
		
		// Weapon Layer
		temp_weapon.layer = layers[3];
		
		// Aiming Behaviour
		temp_weapon.aiming = false;
		temp_weapon.weapon_rotation = temp_weapon.weapon_rotation mod 360;
		if (reload) {
			// Set Gun Tilt
			var temp_weapon_target_angle = point_direction(0, 0, sign(image_xscale), -2);
			var temp_weapon_delta_angle = angle_difference(temp_weapon.weapon_rotation, temp_weapon_target_angle);
			temp_weapon.weapon_rotation = temp_weapon.weapon_rotation - (temp_weapon_delta_angle * temp_weapon.lerp_spd * global.deltatime);
			
			// Set Hand Behaviour
			var temp_hand_x = 0;
			var temp_hand_y = 0;
			var temp_time = 0;
			switch (action_index) {
				case 0:
					var temp_inventory_distance = point_distance(0, 0, (draw_xscale * image_xscale * inventory_x), (draw_yscale * image_yscale * inventory_y));
					var temp_inventory_direction = point_direction(0, 0, (draw_xscale * image_xscale * inventory_x), (draw_yscale * image_yscale * inventory_y));
					temp_hand_x = x + lengthdir_x(temp_inventory_distance, temp_inventory_direction + draw_angle);
					temp_hand_y = y + lengthdir_y(temp_inventory_distance, temp_inventory_direction + draw_angle);
					break;
				case 1:
					var temp_limb_distance = point_distance(0, 0, temp_weapon.reload_x, (temp_weapon.reload_y + temp_weapon.reload_offset_y) * sign(image_xscale));
					var temp_limb_direction = point_direction(0, 0, temp_weapon.reload_x, (temp_weapon.reload_y + temp_weapon.reload_offset_y) * sign(image_xscale));
					temp_hand_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
					temp_hand_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
					temp_time = 20 / (action_spd / 0.15);
					break;
				case 2:
					var temp_limb_distance = point_distance(0, 0, temp_weapon.reload_x, temp_weapon.reload_y * sign(image_xscale));
					var temp_limb_direction = point_direction(0, 0, temp_weapon.reload_x, temp_weapon.reload_y * sign(image_xscale));
					temp_hand_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
					temp_hand_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
					break;
				case 3:
					if (temp_weapon.image_index == 1) {
						if (object_is_ancestor(temp_weapon.object_index, oFirearm)) {
							var temp_ammo = countItemInventory(inventory, temp_weapon.weapon_ammo_id);
							if (temp_ammo > 0) {
								temp_weapon.bullets = temp_weapon.bullets_max;
								removeItemInventory(inventory, temp_weapon.weapon_ammo_id, 1)
							}
						}
						temp_weapon.image_index = 0;
					}
					var temp_limb_distance = point_distance(0, 0, temp_weapon.arm_x[0], temp_weapon.arm_y[0] * sign(image_xscale));
					var temp_limb_direction = point_direction(0, 0, temp_weapon.arm_x[0], temp_weapon.arm_y[0] * sign(image_xscale));
					temp_hand_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
					temp_hand_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
					break;
				default:
					reload = false;
					action = noone;
					break;
			}
			
			// Move Hands
			if (point_distance(action_target_x, action_target_y, temp_hand_x, temp_hand_y) < 1) {
				action_timer -= global.deltatime;
				action_anim_timer -= global.deltatime;
				if (action_anim_timer < 0) {
					action_target_x += random_range(-1, 1);
					action_target_y += random_range(-1, 1);
					action_anim_timer = 6;
				}
				if (action_timer < 0) {
					action_index++;
					action_timer = temp_time;
				}
			}
			else {
				action_target_x = lerp(action_target_x, temp_hand_x, action_spd * global.deltatime);
				action_target_y = lerp(action_target_y, temp_hand_y, action_spd * global.deltatime);
			}
		}
		else if (target_manual) {
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
		
		if (action != noone) {
			limb[0].limb_target_x = action_target_x;
			limb[0].limb_target_y = action_target_y;
		}
		
		// Set Arm Position Frontarm
		if (limbs > 1) {
			limb[1].visible = true;
			limb[1].limb_direction = sign(image_xscale);
			
			var temp_limb_anchor_distance = point_distance(0, 0, (draw_xscale * image_xscale * limb_x[1]) + temp_arm_x_offset, (draw_yscale * image_yscale * limb_y[0]));
			var temp_limb_anchor_direction = point_direction(0, 0, (draw_xscale * image_xscale * limb_x[1]) + temp_arm_x_offset, (draw_yscale * image_yscale * limb_y[0]));
			limb[1].limb_anchor_x = x + lengthdir_x(temp_limb_anchor_distance, draw_angle + temp_limb_anchor_direction) + temp_limb_aim_move_offset_x;
			limb[1].limb_anchor_y = y + lengthdir_y(temp_limb_anchor_distance, draw_angle + temp_limb_anchor_direction) + temp_limb_aim_offset_y;
			
			var temp_limb_distance = point_distance(0, 0, temp_weapon.arm_x[1], temp_weapon.arm_y[1] * sign(image_xscale));
			var temp_limb_direction = point_direction(0, 0, temp_weapon.arm_x[1], temp_weapon.arm_y[1] * sign(image_xscale));
		
			
			if (temp_weapon.double_handed) {
				limb[1].limb_target_x = temp_weapon.x + temp_weapon.recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
				limb[1].limb_target_y = temp_weapon.y + temp_weapon.recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + temp_weapon.weapon_rotation + temp_weapon.recoil_angle_shift);
			}
			else {
				// Ambient Arms BROKEN FIX PLEASE
				limb[1].limb_target_x = x + ((sprite_get_xoffset(sprite_index) * image_xscale) / 2);
				limb[1].limb_target_y = y - (sprite_get_yoffset(sprite_index) / 2);
			}
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