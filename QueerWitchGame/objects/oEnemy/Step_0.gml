/// @description Enemy Update Event
// Calculates the behaviour and necesary functions of the enemy object

// Behaviour
if (!combat_mode) {
	if (behaviour_state == enemybehaviour.guard) {
		
	}
	else if (behaviour_state == enemybehaviour.patrol) {
		
	}
}
else {
	
}

/*********/
/* DEBUG */
/*********/
if (mouse_check_button_pressed(mb_left)) {
	pathfinding_active = true;
	target_x = mouse_room_x();
	target_y = mouse_room_y();
}
if (mouse_check_button_pressed(mb_right)) {
	if (!platform_free(x, y + 1, platform_list)) {
		// First Jump
		y_velocity = 0;
		y_velocity -= jump_spd;
		//jump_velocity = jump_hold_spd;
			
		// Squash and Stretch
		draw_xscale = 1 - squash_stretch;
		draw_yscale = 1 + squash_stretch;
	}
}

// Movement Pathfinding
if (pathfinding_active) {
	// Basic Pathfinding
	if (pathfinding_type == pathfinding.basic) {
		// Horizontal Basic Pathfinding
		if (abs(target_x - x) > 1) {
			var temp_x_spd = min(abs(target_x - x), spd);
			x_velocity = sign(target_x - x) * temp_x_spd;
		}
		else {
			x_velocity = 0;
			// TEMP
			pathfinding_active = false;
		}
	}
}

// Physics
if (platform_free(x, y + 1, platform_list)) {
	//Gravity
	grav_velocity += grav;
	grav_velocity *= grav_multiplier;
	grav_velocity = min(grav_velocity, max_grav);
	y_velocity += grav_velocity;
}
else {
	grav_velocity = 0;
}

var hspd = 0
if (x_velocity != 0) {
	// Horizontal Collisions
	if (place_free(x + x_velocity, y)) {
		// Move Unit with horizontal velocity
		hspd += x_velocity;
		
		// Downward Slope collision check
		if (y_velocity == 0) {
			if (!place_free(x + x_velocity, y + slope_tolerance)) {
				var prev_slope_y = 0;
				for (var i = 0.5; i <= abs(slope_tolerance); i += 0.5) {
					if (!place_free(x + x_velocity, y + (sign(slope_tolerance) * i))) {
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
		if (!place_free(x, y + 1) && place_free(x + x_velocity, y - slope_tolerance)) {
			for (var i = 0; i <= abs(slope_tolerance); i += 0.5) {
				if (place_free(x + x_velocity, y - (sign(slope_tolerance) * i))) {
					hspd += x_velocity;
					y -= sign(slope_tolerance) * i;
					break;
				}
			}
		}
		else {
			// Stop Unit momentum with Collision
			for (var i = abs(x_velocity); i > 0; i -= 0.5) {
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
if (y_velocity != 0) {
	// Vertical Collisions
	if (platform_free(x, y + y_velocity, platform_list)) {
		vspd += y_velocity;
	}
	else {
		for (var i = abs(y_velocity); i > 0; i -= 0.5) {
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