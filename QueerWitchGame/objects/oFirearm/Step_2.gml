/// @description Firearm Update
// Calculates the behaviour of the firearm object

// Inherit the parent event
event_inherited();

// Deltatime Calc
var temp_deltatime = global.deltatime;
if (use_realdeltatime) {
	temp_deltatime = global.realdeltatime;
}

/// Weapon Position
x = lerp(x, x_position, move_spd * temp_deltatime);
y = lerp(y, y_position, move_spd * temp_deltatime);

var temp_x = x + recoil_offset_x;
var temp_y = y + recoil_offset_y;

// Weapon Scaling & Rotation
if (temp_x + lengthdir_x(5, weapon_rotation) < temp_x) {
	weapon_yscale = -1;
}
else {
	weapon_yscale = 1;
}

var temp_weapon_rotation = weapon_rotation + recoil_angle_shift;

// Set Fire Mode Behaviour
if (attack) {
	// Calculate Weapon Muzzle Position
	var temp_muzzle_direction = point_direction(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);
	var temp_muzzle_distance = point_distance(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);

	var temp_muzzle_x = temp_x + lengthdir_x(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
	var temp_muzzle_y = temp_y + lengthdir_y(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);

	// Door Muzzle Clip Check
	var temp_muzzle_door_clipping = false;
	var temp_door_instance = instance_position(temp_muzzle_x, temp_muzzle_y, oDoor);
	if (temp_door_instance != noone) {
		if (!temp_door_instance.door_touched) {
			var temp_door_instance_x = temp_door_instance.x + ((sprite_get_width(temp_door_instance.end_panel_sprite) / 2) * sign(temp_x - temp_door_instance.x));
			if (sign(temp_x - temp_door_instance_x) != sign(temp_muzzle_x - temp_door_instance_x)) {
				temp_muzzle_door_clipping = true;
			}
		}
	}
	
	// Attack Variable Behaviour
	attack = false;
	if (!temp_muzzle_door_clipping) {
		if (bullets > 0) {
			if (click) {
				bursts = min(max(burst, 1), bullets);
				bursts_timer = 0;
				bullets -= bursts;
			}
			else {
				bursts_timer -= temp_deltatime;
				if (bursts_timer <= 0) {
					bursts = min(max(burst, 1), bullets);
					bursts_timer = 0;
					bullets -= bursts;
				}
			}
		}
	}
}
else {
	if (!click) {
		bursts_timer = 0;
	}
}

// Firearm Behaviour
if (aiming) {
	aim = lerp(aim, 1, aim_spd * temp_deltatime);
	var temp_accuracy = clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak;
	if (temp_accuracy <= accuracy_peak + 0.1) {
		aim = 1;
	}
	aim_hip_max = aim;
}
else {
	aim = lerp(aim, clamp(aim_hip_max - 0.4, 0, 1), (aim_spd * 0.7) * temp_deltatime);
}

// Fire Behaviour
if (bursts > 0) {
	bursts_timer -= temp_deltatime;
	if (bursts_timer <= 0) {
		// Burst Behaviour
		bursts--;
		bursts_timer = burst_delay
	
		// Projectiles
		for (var i = 0; i < projectiles; i++) {
			// Direction
			var temp_accuracy = (clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak) / 2;
			var temp_hitscan_angle = temp_weapon_rotation + random_range(-temp_accuracy, temp_accuracy);
			
			// Flash
			ds_list_add(flash_direction, temp_hitscan_angle);
			ds_list_add(flash_timer, flash_delay);
			
			if (muzzle_flash_sprite != noone) {
				if (i == 0) {
					ds_list_add(flash_imageindex, random_range(0, sprite_get_number(muzzle_flash_sprite)));
				}
				else {
					ds_list_add(flash_imageindex, -1);
				}
			}
			
			// Position
			var temp_muzzle_direction = point_direction(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);
			var temp_muzzle_distance = point_distance(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale) - 2;

			var temp_muzzle_x = temp_x + lengthdir_x(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
			var temp_muzzle_y = temp_y + lengthdir_y(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
			
			ds_list_add(flash_xposition, temp_muzzle_x);
			ds_list_add(flash_yposition, temp_muzzle_y);
			
			// Disable Door Colliders
			var temp_doors_active = noone;
			for (var l = 0; l < instance_number(oDoor); l++) {
				var temp_door_inst = instance_find(oDoor, l);
				if (instance_exists(temp_door_inst.door_solid)) {
					if (temp_door_inst.door_solid_active) {
						temp_doors_active[l] = temp_door_inst.door_solid;
						instance_deactivate_object(temp_door_inst.door_solid);
					}
				}
			}
			
			// Raycast
			var temp_hit_diceroll = random(1);
			
			var temp_collision_array_miss = noone;
			if (random(1) <= 0.5) {
				temp_collision_array_miss[0] = oMaterial;
			}
			
			var temp_raycast_data = noone;
			while (true) {
				// Raycast Variables
				var temp_collision_array = noone;
				var temp_raycast_origin_x = temp_muzzle_x;
				var temp_raycast_origin_y = temp_muzzle_y;
				
				// Close Range Raycast
				temp_collision_array = temp_collision_array_miss;
				if (temp_hit_diceroll <= close_range_hit_chance) {
					temp_collision_array = collider_array_hit;
				}
				
				temp_raycast_data = raycast_combat_line(temp_raycast_origin_x, temp_raycast_origin_y, temp_hitscan_angle, close_range_radius, temp_collision_array, ignore_id);
				if (temp_raycast_data[4] == noone) {
					temp_raycast_origin_x = temp_muzzle_x + (close_range_radius * cos(degtorad(temp_hitscan_angle)));
					temp_raycast_origin_y = temp_muzzle_y + (close_range_radius * -sin(degtorad(temp_hitscan_angle)));
				}
				else {
					break;
				}
				
				// Mid Range Raycast
				temp_collision_array = temp_collision_array_miss;
				if (temp_hit_diceroll <= mid_range_hit_chance) {
					temp_collision_array = collider_array_hit;
				}
				
				temp_raycast_data = raycast_combat_line(temp_raycast_origin_x, temp_raycast_origin_y, temp_hitscan_angle, mid_range_radius - close_range_radius, temp_collision_array, ignore_id);
				temp_raycast_data[0] += close_range_radius;
				if (temp_raycast_data[4] == noone) {
					temp_raycast_origin_x = temp_muzzle_x + (mid_range_radius * cos(degtorad(temp_hitscan_angle)));
					temp_raycast_origin_y = temp_muzzle_y + (mid_range_radius * -sin(degtorad(temp_hitscan_angle)));
				}
				else {
					break;
				}
			
				// Far Range Raycast
				temp_collision_array = temp_collision_array_miss;
				if (temp_hit_diceroll <= far_range_hit_chance) {
					temp_collision_array = collider_array_hit;
				}
				
				temp_raycast_data = raycast_combat_line(temp_raycast_origin_x, temp_raycast_origin_y, temp_hitscan_angle, far_range_radius - mid_range_radius, temp_collision_array, ignore_id);
				temp_raycast_data[0] += mid_range_radius;
				if (temp_raycast_data[4] == noone) {
					temp_raycast_origin_x = temp_muzzle_x + (far_range_radius * cos(degtorad(temp_hitscan_angle)));
					temp_raycast_origin_y = temp_muzzle_y + (far_range_radius * -sin(degtorad(temp_hitscan_angle)));
				}
				else {
					break;
				}
			
				// Sniper Range Raycast
				temp_collision_array = temp_collision_array_miss;
				if (temp_hit_diceroll <= sniper_range_hit_chance) {
					temp_collision_array = collider_array_hit;
				}
				
				temp_raycast_data = raycast_combat_line(temp_raycast_origin_x, temp_raycast_origin_y, temp_hitscan_angle, range - far_range_radius, temp_collision_array, ignore_id);
				temp_raycast_data[0] += far_range_radius;
				
				break;
			}
			
			// Hit Calculation
			if (temp_raycast_data[4] != noone) {
				// Check Hit Collider Object Type
				if (temp_raycast_data[3] == oUnit) {
					// Unit Calculation
					var temp_unit = temp_raycast_data[4];
					temp_unit.health_points -= damage;
					temp_unit.health_points = clamp(temp_unit.health_points, 0, temp_unit.max_health_points);
			
					// Ragdoll Effect
					if (temp_unit.health_points == 0) {
						temp_unit.force_applied = true;
						temp_unit.force_x = temp_raycast_data[1];
						temp_unit.force_y = temp_raycast_data[2];
						temp_unit.force_xvector = cos(degtorad(temp_hitscan_angle)) * 15;
						temp_unit.force_yvector = sin(degtorad(temp_hitscan_angle)) * 15;
					}
				}
				else if (temp_raycast_data[3] == oMaterial) {
					// Add Material Damage
					material_add_damage(temp_raycast_data[4], material_damage_sprite, irandom(sprite_get_number(material_damage_sprite)), temp_raycast_data[1], temp_raycast_data[2], 1, 1, random(360));
				}
			}
			
			// Re-enable All Door Colliders
			for (var l = 0; l < array_length_1d(temp_doors_active); l++) {
				instance_activate_object(temp_doors_active[l]);
			}
			
			// Bullet Trail
			var temp_bullet_trail_length = temp_raycast_data[0];
			ds_list_add(flash_length, temp_bullet_trail_length);
		}
		
		// Sound
		if (!silent) {
			// Index all oUnitAI objects within Firearm Sound Radius
			var temp_sound_radius_unit_list = ds_list_create();
			var temp_sound_radius_units_num = collision_circle_list(temp_x, temp_y, sound_radius, oUnitAI, false, true, temp_sound_radius_unit_list, false);
			
			// Interate through Sound Radius Unit List
			for (var q = 0; q < temp_sound_radius_units_num; q++) {
				var temp_sound_unit = ds_list_find_value(temp_sound_radius_unit_list, q);
				if (temp_sound_unit.team_id != ignore_id) {
					temp_sound_unit.sight_unit_seen = true;
					temp_sound_unit.sight_unit_seen_x = temp_x;
					temp_sound_unit.sight_unit_seen_y = temp_y;
					temp_sound_unit.alert = 1;
				}
			}
			
			// Garbage Collection
			ds_list_destroy(temp_sound_radius_unit_list);
		}
		
		// Bullet Cases
		if (case_sprite != noone) {
			bullet_cases++;
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
	}
}

// Flash
for (var f = ds_list_size(flash_timer) - 1; f >= 0; f--) {
	var temp_flash_timer = ds_list_find_value(flash_timer, f);
	temp_flash_timer -= temp_deltatime;
	if (temp_flash_timer <= 0) {
		if (!instance_exists(oKnockout)) {
			ds_list_delete(flash_timer, f);
			ds_list_delete(flash_length, f);
			ds_list_delete(flash_direction, f);
			ds_list_delete(flash_xposition, f);
			ds_list_delete(flash_yposition, f);
			ds_list_delete(flash_imageindex, f);
			continue;
		}
		else {
			temp_flash_timer = 0;
		}
	}
	ds_list_set(flash_timer, f, temp_flash_timer);
}

// Recoil
if (recoil_timer > 0) {
	recoil_timer -= temp_deltatime;
	recoil_velocity += recoil_spd * temp_deltatime;
	recoil_offset_x += lengthdir_x(recoil_velocity, recoil_position_direction + temp_weapon_rotation) * temp_deltatime;
	recoil_offset_y += lengthdir_y(recoil_velocity, recoil_position_direction + temp_weapon_rotation) * temp_deltatime;
	
	var temp_recoil_distance = point_distance(recoil_offset_x, recoil_offset_y, 0, 0);
	if (temp_recoil_distance > recoil_clamp) {
		recoil_offset_x = lengthdir_x(recoil_clamp, recoil_position_direction + temp_weapon_rotation);
		recoil_offset_y = lengthdir_y(recoil_clamp, recoil_position_direction + temp_weapon_rotation);
	}
}
else {
	aiming = true;
	recoil_angle_shift = lerp(recoil_angle_shift, 0, angle_adjust_spd * temp_deltatime);
	recoil_offset_x = lerp(recoil_offset_x, 0, lerp_spd * temp_deltatime);
	recoil_offset_y = lerp(recoil_offset_y, 0, lerp_spd * temp_deltatime);
}

// Bullet Cases
if (bullet_cases != 0) {
	for (var c = 0; c < bullet_cases; c++) {
		var temp_eject_direction = point_direction(0, 0, case_eject_x * weapon_xscale, case_eject_y * weapon_yscale);
		var temp_eject_distance = point_distance(0, 0, case_eject_x * weapon_xscale, case_eject_y * weapon_yscale);
		
		var temp_eject_x = x + recoil_offset_x + lengthdir_x(temp_eject_distance, temp_weapon_rotation + temp_eject_direction);
		var temp_eject_y = y + recoil_offset_y + lengthdir_y(temp_eject_distance, temp_weapon_rotation + temp_eject_direction);
		
		var temp_case = instance_create_layer(temp_eject_x, temp_eject_y, layer, oBulletCase);
		temp_case.case_direction = (weapon_rotation + ((-90 * weapon_yscale) - 180)) + (random_range(0, case_direction) * weapon_yscale);
		temp_case.sprite_index = case_sprite;
		temp_case.image_xscale = weapon_yscale;
	}
	bullet_cases = 0;
}

// Hit Effect
if (instance_exists(oKnockout)) {
	hit_effect_offset += temp_deltatime;
	hit_effect_xscale += temp_deltatime * 0.1;
	hit_effect_yscale -= temp_deltatime * 0.05;
	if (hit_effect_index == -1) {
		hit_effect_index = irandom_range(0, sprite_get_number(sImpact_Blood));
		hit_effect_xscale = 0.8;
		hit_effect_yscale = 1;
		if (random_range(0, 1) <= 0.5) {
			hit_effect_yscale = -1;
		}
		hit_effect_yscale *= random_range(0.7, 1);
		hit_effect_sign = sign(hit_effect_yscale);
	}
}
else {
	hit_effect_index = -1;
	hit_effect_offset = 0;
}