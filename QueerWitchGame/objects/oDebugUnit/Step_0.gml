/// @description Unit Update Event
// performs calculations necessary for the Unit's behavior

// Key Checks
key_left = keyboard_check(ord("A"));
key_right = keyboard_check(ord("D"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));

key_left_press = keyboard_check_pressed(ord("A"));
key_right_press = keyboard_check_pressed(ord("D"));
key_up_press = keyboard_check_pressed(ord("W"));
key_down_press = keyboard_check_pressed(ord("S"));

// Movement (Player Input)
if (canmove) {
	// Move player left and right
	if (key_left) {
		x_velocity = -spd;
	}
	else if (key_right) {
		x_velocity = spd;
	}
	else {
		x_velocity = 0;
	}
	
	// Jumping
	if (key_up) {
		if (!place_free(x, y + 1)) {
			// First Jump
			y_velocity = 0;
			y_velocity -= jump_spd;
			jump_velocity = jump_hold_spd;
			double_jump = true;
			
			// Squash and Stretch
			draw_xscale = 1 - squash_stretch;
			draw_yscale = 1 + squash_stretch;
		}
		else if (key_up_press) {
			// Double Jump
			if (double_jump) {
				y_velocity = 0;
				y_velocity -= jump_double_spd;
				jump_velocity = jump_hold_spd;
				double_jump = false;
			}
		}
		else if (y_velocity < 0) {
			// Variable Jump Height
			y_velocity -= jump_velocity;
			jump_velocity *= jump_decay;
		}
	}
}

// Physics
if (place_free(x, y + 1)) {
	//Gravity
	grav_velocity += grav;
	grav_velocity *= grav_multiplier;
	grav_velocity = min(grav_velocity, max_grav);
	y_velocity += grav_velocity;
}
else {
	grav_velocity = 0;
}

hspd = 0
if (x_velocity != 0) {
	// Horizontal Collisions
	if (place_free(x + x_velocity, y)) {
		hspd += x_velocity;
	}
	else {
		for (i = abs(x_velocity); i > 0; i -= 0.5) {
			if (place_free(x + (i * sign(x_velocity)), y)) {
				hspd += i * sign(x_velocity);
				break;
			}
		}
		x_velocity = 0;
	}
}

vspd = 0;
if (y_velocity != 0) {
	// Vertical Collisions
	if (place_free(x, y + y_velocity)) {
		vspd += y_velocity;
	}
	else {
		for (i = abs(y_velocity); i > 0; i -= 0.5) {
			if (place_free(x, y + (i * sign(y_velocity)))) {
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

sprite_index = idle_anim;
if (!place_free(x, y + 1)) {
	if (hspd != 0) {
		sprite_index = walk_anim;
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

// Camera Movement
if (camera_follow) {
	var camera = view_camera[0];
	var cam_width = camera_get_view_width(camera);
	var cam_height = camera_get_view_height(camera);
	var cam_x = camera_get_view_x(camera);
	var cam_y = camera_get_view_y(camera);
	
	var cam_target_x = lerp(cam_x, x - (cam_width / 2), camera_follow_spd);
	var cam_target_y = lerp(cam_y, y - (cam_height / 2) + camera_y_offset, camera_follow_spd);
	
	camera_set_view_pos(camera, cam_target_x, cam_target_y);
}