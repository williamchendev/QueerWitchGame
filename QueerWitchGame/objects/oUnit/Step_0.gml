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
			//draw_xscale = 1 - squash_stretch;
			//draw_yscale = 1 + squash_stretch;
		}
		else if (key_up_press) {
			// Second Jump
			if (double_jump) {
				y_velocity = 0;
				y_velocity -= double_jump_spd;
				jump_velocity = hold_jump_spd;
				double_jump = false;
				
				// Squash and Stretch
				//draw_xscale = 1 - squash_stretch;
				//draw_yscale = 1 + squash_stretch;
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
show_debug_message(global.deltatime);

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
		//draw_xscale = 1 + squash_stretch;
		//draw_yscale = 1 - squash_stretch;
	}
}

x += hspd;
y += vspd;

/*

// Animation
if (!game_manager.stop_time) {
	draw_xscale = lerp(draw_xscale, 1, 0.1);
	draw_yscale = lerp(draw_yscale, 1, 0.1);

	if (hspd != 0) {
		// Set Sprite facing direction
		image_xscale = sign(hspd);	
	}

	if (!platform_free(x, y + 1, platform_list)) {
		if (hspd != 0) {
			sprite_index = walk_anim;
		}
		else {
			sprite_index = idle_anim;
		}
	}
	else {
		sprite_index = jump_anim;
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

	var slope_solid_obj = collision_line(x, y, x, y + 5, oSolid, false, false);
	if (slope_solid_obj != noone) {
		slope_angle = lerp(slope_angle, slope_solid_obj.image_angle, slope_lerp_spd);
		slope_offset = 0;
		if (slope_solid_obj.image_angle != 0) {
			slope_offset = slope_tolerance;
		}
	}
	else {
		slope_angle = lerp(slope_angle, 0, slope_lerp_spd);
		slope_offset = 0;
	}
}

*/