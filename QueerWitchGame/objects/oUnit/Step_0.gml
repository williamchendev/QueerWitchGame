/// @description Unit Update Event
// Performs calculations necessary for the Unit's behavior

// Key Checks (Player Input)
var key_left = false;
var key_right = false;
var key_up = false;
var key_down = false;

var key_left_press = false;
var key_right_press = false;
var key_up_press = false;
var key_down_press = false;

var key_select_press = false;
var key_cancel_press = false;
var key_menu_press = false;

if (player_input) {
	if (game_manager != noone) {
		key_left = keyboard_check(game_manager.left_check);
		key_right = keyboard_check(game_manager.right_check);
		key_up = keyboard_check(game_manager.up_check);
		key_down = keyboard_check(game_manager.down_check);

		key_left_press = keyboard_check_pressed(game_manager.left_check);
		key_right_press = keyboard_check_pressed(game_manager.right_check);
		key_up_press = keyboard_check_pressed(game_manager.up_check);
		key_down_press = keyboard_check_pressed(game_manager.down_check);
		
		key_select_press = keyboard_check_pressed(game_manager.select_check);
		key_cancel_press = keyboard_check_pressed(game_manager.cancel_check);
		key_menu_press = keyboard_check_pressed(game_manager.menu_check);
	}
}

// Movement (Player Input)
if (canmove) {
	// Horizontal Movement
	if (key_left) {
		x_velocity = -spd;
	}
	else if (key_right) {
		x_velocity = spd;
	}
	else {
		x_velocity = 0;
	}
	
	// Vertical Movement (Jumping)
	if (key_up) {
		if (!platform_free(x, y + 1, platform_list)) {
			// First Jump
			y_velocity = 0;
			y_velocity -= jump_spd;
			jump_velocity = hold_jump_spd;
			double_jump = true;
			
			// Squash and Stretch
			draw_xscale = 1 - squash_stretch;
			draw_yscale = 1 + squash_stretch;
		}
		else if (key_up_press) {
			// Second Jump
			if (double_jump) {
				y_velocity = 0;
				y_velocity -= double_jump_spd;
				jump_velocity = hold_jump_spd;
				double_jump = false;
				
				// Squash and Stretch
				draw_xscale -= squash_stretch;
				draw_yscale += squash_stretch;
			}
		}
		else if (y_velocity < 0) {
			// Variable Jump Height
			y_velocity -= jump_velocity * global.deltatime;
			jump_velocity *= power(jump_decay, global.deltatime);
		}
	}
	
	// Jumping Down (Platforms)
	if (key_down_press) {
		if (place_free(x, y + 1) and !platform_free(x, y + 1, platform_list)) {
			y += 1;
			y_velocity += 0.05;
		}
	}
}

// Physics
if (platform_free(x, y + 1, platform_list)) {
	//Gravity
	grav_velocity += (grav_spd * global.deltatime);
	grav_velocity *= power(grav_multiplier, global.deltatime);
	grav_velocity = min(grav_velocity, max_grav_spd);
	y_velocity += (grav_velocity * global.deltatime);
}
else {
	grav_velocity = 0;
}
	
// Delta Time
var temp_x_velocity = x_velocity * global.deltatime;
var temp_y_velocity = y_velocity * global.deltatime;

var hspd = 0
if (temp_x_velocity != 0) {
	// Horizontal Collisions
	if (place_free(x + temp_x_velocity, y)) {
		// Move Unit with horizontal velocity
		hspd += temp_x_velocity;
		
		// Downward Slope collision check
		if (temp_y_velocity == 0) {
			if (!place_free(x + temp_x_velocity, y + slope_tolerance)) {
				var prev_slope_y = 0;
				for (var i = 0.5; i <= abs(slope_tolerance); i += 0.5) {
					if (!place_free(x + temp_x_velocity, y + (sign(slope_tolerance) * i))) {
						y += sign(slope_tolerance) * prev_slope_y;
						break;
					}
					prev_slope_y = i;
				}
			}
		}
	}
	else {
		// Upward Slope collision check
		if (!place_free(x, y + 1) && place_free(x + temp_x_velocity, y - slope_tolerance)) {
			for (var i = 0; i <= abs(slope_tolerance); i += 0.5) {
				if (place_free(x + temp_x_velocity, y - (sign(slope_tolerance) * i))) {
					hspd += temp_x_velocity;
					y -= sign(slope_tolerance) * i;
					break;
				}
			}
		}
		else {
			// Stop Unit momentum with Collision
			for (var i = abs(temp_x_velocity); i > 0; i -= 0.5) {
				if (place_free(x + (i * sign(x_velocity)), y)) {
					hspd += i * sign(x_velocity);
					break;
				}
			}
			x_velocity = 0;
		}
	}
}

var vspd = 0;
if (temp_y_velocity != 0) {
	// Vertical Collisions
	if (platform_free(x, y + temp_y_velocity, platform_list)) {
		vspd += temp_y_velocity;
	}
	else {
		for (var i = abs(temp_y_velocity); i > 0; i -= 0.5) {
			if (platform_free(x, y + (i * sign(y_velocity)), platform_list)) {
				vspd += i * sign(y_velocity);
				break;
			}
		}
		y_velocity = 0;
		
		// Squash and Stretch
		draw_xscale = 1 + squash_stretch;
		draw_yscale = 1 - squash_stretch;
	}
}

x += hspd;
y += vspd;

// Animation
draw_xscale = lerp(draw_xscale, 1, scale_reset_spd * global.deltatime);
draw_yscale = lerp(draw_yscale, 1, scale_reset_spd * global.deltatime);

if (hspd != 0) {
	// Set Sprite facing direction
	image_xscale = sign(hspd);	
}

if (!platform_free(x, y + 1, platform_list)) {
	if (hspd != 0) {
		sprite_index = walk_animation;
	}
	else {
		sprite_index = idle_animation;
	}
	
	draw_index += animation_spd * global.deltatime;
	while (draw_index > sprite_get_number(sprite_index)) {
		draw_index -= sprite_get_number(sprite_index);
	}
	image_index = clamp(floor(draw_index), 0, sprite_get_number(sprite_index) - 1);
}
else {
	sprite_index = jump_animation;
	if (vspd < 0.15) {
		image_index = 0;
	}
	else if (vspd > 0.15) {
		image_index = 2;
	}
	else {
		image_index = 1;
	}
}

// Weapons
arms[0].visible = false;
arms[1].visible = false;
for (var i = 0; i < array_length_1d(weapons); i++) {
	if (weapons[i].equip) {
		// Weapon Behaviour
		if (key_select_press) {
			// Fire Weapon
			weapons[i].attack = canmove;
		}
		
		if (target != noone) {
			// Aim Weapon
			weapons[i].aiming = false;
			if (abs(hspd) <= 0.1) {
				if (!platform_free(x, y + 1, platform_list)) {
					if (target.x > x) {
						weapons[i].aiming = true;
						weapons[i].weapon_rotation = point_direction(x + weapon_x, y + weapon_y, target.x, target.y);
					}
				}
			}
		}
		else {
			// Ambient Aiming
			weapons[i].aiming = false;
			aim_ambient_x = lerp(aim_ambient_x, x + (draw_xscale * image_xscale * 50), weapons[i].lerp_spd * global.deltatime);
			aim_ambient_y = lerp(aim_ambient_y, y + weapon_hip_y, weapons[i].lerp_spd * global.deltatime);
			weapons[i].weapon_rotation = point_direction(x + weapon_x, y + weapon_y, aim_ambient_x, aim_ambient_y);
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
		//weapons[i].weapon_rotation = 90 - (90 * image_xscale);
		
		// Establish Arm Variables
		var temp_arm_direction = 0;
		if (sign(image_xscale) < 0) {
			temp_arm_direction = 1;
		}
		
		// Set Arm Position Backarm
		arms[0].visible = true;
		arms[0].limb_direction = sign(image_xscale);
		
		arms[0].limb_anchor_x = x + (draw_xscale * image_xscale * arm_x[0]);
		arms[0].limb_anchor_y = y + (draw_yscale * image_yscale * arm_y[0]);
		
		var temp_limb_distance = point_distance(0, 0, weapons[i].arm_x[0], weapons[i].arm_y[0] * sign(image_xscale));
		var temp_limb_direction = point_direction(0, 0, weapons[i].arm_x[0], weapons[i].arm_y[0] * sign(image_xscale));
		
		arms[0].limb_target_x = weapons[i].x + weapons[i].recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
		arms[0].limb_target_y = weapons[i].y + weapons[i].recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
		
		// Set Arm Position Frontarm
		if (weapons[i].double_handed) {
			arms[1].visible = true;
			arms[1].limb_direction = sign(image_xscale);
			
			arms[1].limb_anchor_x = x + (draw_xscale * image_xscale * arm_x[1]);
			arms[1].limb_anchor_y = y + (draw_yscale * image_yscale * arm_y[1]);
			
			var temp_limb_distance = point_distance(0, 0, weapons[i].arm_x[1], weapons[i].arm_y[1] * sign(image_xscale));
			var temp_limb_direction = point_direction(0, 0, weapons[i].arm_x[1], weapons[i].arm_y[1] * sign(image_xscale));
		
			arms[1].limb_target_x = weapons[i].x + weapons[i].recoil_offset_x + lengthdir_x(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
			arms[1].limb_target_y = weapons[i].y + weapons[i].recoil_offset_y + lengthdir_y(temp_limb_distance, temp_limb_direction + weapons[i].weapon_rotation + weapons[i].recoil_angle_shift);
		}
	}
}

/*
var slope_solid_obj = collision_line(x, y, x, y + 5, oSolid, false, false);
if (slope_solid_obj != noone) {
	slope_angle = lerp(slope_angle, slope_solid_obj.image_angle, slope_angle_lerp_spd);
	slope_offset = 0;
	if (slope_solid_obj.image_angle != 0) {
		slope_offset = slope_tolerance;
	}
}
else {
	slope_angle = lerp(slope_angle, 0, slope_lerp_spd);
	slope_offset = 0;
}
*/