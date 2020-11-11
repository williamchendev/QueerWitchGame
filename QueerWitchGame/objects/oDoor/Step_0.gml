/// @description Insert description here
// You can write your code in this editor

// Door Interact Behaviour
if (interact.interact_action) {
	// Check if Unit Exists in Door Solid Space
	var temp_door_unit_check = collision_rectangle(x - (sprite_get_width(end_panel_sprite) / 2), y - sprite_get_height(end_panel_sprite), x + (sprite_get_width(end_panel_sprite) / 2), y, oUnit, false, true);
	if (temp_door_unit_check == noone) {
		// Set Door Behaviour
		if (!door_touched) {
			door_material.material_team_id = interact.interact_unit.team_id;
			
			door_velocity = door_kick_velocity * -sign(interact.interact_unit.x - x);
			door_open = true;
		}
		else {
			door_open = false;
		}
		door_touched = true;
	}
	
	// Reset Interact Behaviour
	interact.interact_action = false;
	interact.interact_unit = noone;
}

// Door Physics
if (door_open) {
	// Door Physical Colliders
	if (abs(door_value) < door_collider_value) {
		// Door End Panel Collider Variables
		var temp_draw_val = sin(door_value * 0.5 * pi);
		var temp_door_end_width = sprite_get_width(end_panel_sprite) / 2;
		var temp_door_end_collider_x = x + (temp_draw_val * sprite_get_width(panel_sprite)) - (door_value * (sprite_get_width(end_panel_sprite) / 2));
		
		// Physics Collision Check
		var temp_universal_physics_obj = collision_rectangle(temp_door_end_collider_x - temp_door_end_width - door_collider_offset, y - sprite_get_height(end_panel_sprite), temp_door_end_collider_x + temp_door_end_width + door_collider_offset, y, oPhysics, false, true);
		if (temp_universal_physics_obj != noone) {
			if (temp_universal_physics_obj.hspd != 0) {
				var temp_velocity = temp_universal_physics_obj.hspd / (sprite_get_width(panel_sprite) * 2);
				door_velocity += temp_velocity;
				door_touched = true;
			}
			else {
				if (sign(door_velocity) == sign(temp_universal_physics_obj.x - temp_door_end_collider_x)) {
					door_velocity *= -1;
				}
			}
		}
	}
	else {
		// Door Panel Collider Variables
		var temp_draw_val = sin(door_value * 0.5 * pi);
		var temp_door_end_collider_x = x + (temp_draw_val * sprite_get_width(panel_sprite));
		
		// Unit Physics Collision Check
		var temp_unit_obj = collision_rectangle(x, y - sprite_get_height(panel_sprite), temp_door_end_collider_x, y, oUnit, false, true);
		if (temp_unit_obj != noone) {
			if (door_value >= door_collider_value) {
				door_min = door_collider_value;
			}
			else {
				door_max = -door_collider_value;
			}
		}
		else {
			door_min = -1;
			door_max = 1;
		}
	}
	
	// Door Slam Velocity
	var temp_physics_calc = true;
	if (door_slam_timer > 0) {
		door_slam_timer -= global.deltatime;
		temp_physics_calc = false;
		if (door_slam_timer <= 0) {
			door_velocity *= -door_slam_friction;
			door_value -= door_slam_velocity;
			temp_physics_calc = true;
		}
	}

	// Door Velocity
	if (door_velocity != 0) {
		if (temp_physics_calc) {
			door_value += door_velocity * global.deltatime;
			door_velocity *= power(door_friction, global.deltatime);
			if (abs(door_velocity) < 0.005) {
				door_velocity = 0;
			}
	
			if (door_value < door_min) {
				door_slam_velocity = door_value - door_min;
				door_value = door_min;
				door_slam_timer = door_slam_delay;
			}
			else if (door_value > door_max) {
				door_slam_velocity = door_value - door_max;
				door_value = door_max;
				door_slam_timer = door_slam_delay;
			}
		}
	}
}
else {
	// Door Lerp Close
	if (door_value != 0) {
		door_value = lerp(door_value, 0, global.deltatime * door_lerp_close_spd);
		if (abs(door_value) < 0.01) {
			door_value = 0;
			door_open = true;
		}
	}
}

// Door Material Instance
if (abs(door_value) < door_collider_value) {
	// Reactivate Instance
	if (!door_material_active) {
		instance_activate_object(door_material);
		door_material_active = true;
	}
	
	// Door End Panel Collider Variables
	var temp_draw_val = sin(door_value * 0.5 * pi);
	var temp_door_end_x = x + (temp_draw_val * sprite_get_width(panel_sprite)) - (door_value * (sprite_get_width(end_panel_sprite) / 2));
	door_material.x = temp_door_end_x;
}
else {
	// Deactivate Instance
	if (door_material_active) {
		instance_deactivate_object(door_material);
		door_material_active = false;
	}
}	

// Door Solid Instance
if (door_open) {
	// Deactivate Instance
	if (door_touched) {
		if (door_solid_active) {
			door_solid.phy_active = false;
			instance_deactivate_object(door_solid);
			door_solid_active = false;
		}
	}
	
	// Set Door Material team_id
	var temp_interact_unit = collision_rectangle(x - ((sprite_get_width(sprite_index) / 2) * sign(door_value)), y - sprite_get_height(end_panel_sprite), x + (door_value * (sprite_get_width(end_panel_sprite) / 2)), y, oUnit, false, true);
	if (temp_interact_unit != noone) {
		door_material.material_team_id = temp_interact_unit.team_id;
	}
}
else {
	// Reactivate Instance
	if (!door_solid_active) {
		instance_activate_object(door_solid);
		door_solid.phy_active = true;
		door_solid_active = true;
		
		door_min = -1;
		door_max = 1;
		door_velocity = 0;
		door_touched = false;
		
		// Set Door Material team_id
		door_material.material_team_id = "unassigned";
	}
}