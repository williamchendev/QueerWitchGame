/// @description Insert description here
// You can write your code in this editor

// Door Behaviour

/*
door_value += global.deltatime * (0.05 * sign(door_timer));
if (abs(door_value) > 1) {
	door_timer *= -1;
}
door_value = clamp(door_value, -1, 1);
*/

if (keyboard_check_pressed(ord("P"))) {
	door_open = !door_open;
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
				var temp_velocity = temp_universal_physics_obj.hspd / sprite_get_width(panel_sprite);
				door_velocity += temp_velocity;
				door_touched = true;
			}
		}
	}
	else {
		// Door Panel Collider Variables
		var temp_draw_val = sin(door_value * 0.5 * pi);
		var temp_door_panel_collider_x = x - (sign(door_value) * (sprite_get_width(end_panel_sprite) / 2));
		var temp_door_end_collider_x = x + (temp_draw_val * sprite_get_width(panel_sprite)) - (door_value * (sprite_get_width(end_panel_sprite) / 2));
		
		// Unit Physics Collision Check
		var temp_unit_obj = collision_rectangle(temp_door_panel_collider_x, y - sprite_get_height(panel_sprite), temp_door_end_collider_x, y, oUnit, false, true);
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
	
	// Door Velocity
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
			instance_deactivate_object(door_solid);
			door_solid_active = false;
		}
	}
}
else {
	// Reactivate Instance
	if (!door_solid_active) {
		instance_activate_object(door_solid);
		door_solid_active = true;
		
		door_min = -1;
		door_max = 1;
		door_touched = false;
	}
}