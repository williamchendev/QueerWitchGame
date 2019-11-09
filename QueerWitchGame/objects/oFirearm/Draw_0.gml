/// @description Firearm Draw
// Draws the firearm object to the screen

// Weapon Rotation
var temp_weapon_rotation = weapon_rotation + recoil_angle_shift;

// Weapon Position
var temp_x = x + recoil_offset_x;
var temp_y = y + recoil_offset_y;

// Calculate Weapon Range & Accuracy
var temp_muzzle_direction = point_direction(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);
var temp_muzzle_distance = point_distance(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);

var temp_muzzle_x = temp_x + lengthdir_x(temp_muzzle_distance + 1, temp_weapon_rotation + temp_muzzle_direction);
var temp_muzzle_y = temp_y + lengthdir_y(temp_muzzle_distance + 1, temp_weapon_rotation + temp_muzzle_direction);

var temp_accuracy = clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak;

if (temp_accuracy > accuracy_peak) {
	draw_set_alpha(clamp(0.5 * power(aim, 3), 0, 0.5));
	draw_set_color(c_black);
}
else {
	draw_set_alpha(0.3);
	draw_set_color(c_white);
}

// Draw Aiming Reticules
var temp_fanlength = (pi * (range * 2)) * (temp_accuracy / 360);
var temp_fantris = floor(temp_fanlength / clamp(temp_accuracy, 1, 10));
var temp_fanseg = (temp_accuracy / temp_fantris);

/*
if (equip) {
	if (!sniper) {
		// Draw Aim Fan Reticule
		if (temp_fantris == 1) {
			var temp_fanangle = (temp_accuracy / 2);
			var temp_point1_x = temp_muzzle_x + lengthdir_x(range, temp_weapon_rotation - temp_fanangle); 
			var temp_point1_y = temp_muzzle_y + lengthdir_y(range, temp_weapon_rotation - temp_fanangle);
			var temp_point2_x = temp_muzzle_x + lengthdir_x(range, temp_weapon_rotation + temp_fanangle); 
			var temp_point2_y = temp_muzzle_y + lengthdir_y(range, temp_weapon_rotation + temp_fanangle);
			draw_triangle(temp_point1_x, temp_point1_y, temp_muzzle_x, temp_muzzle_y, temp_point2_x, temp_point2_y, false);
		}
		else {
			draw_primitive_begin(pr_trianglestrip);
			for (var i = 0; i < temp_fantris; i++) {
				var temp_fanangle = temp_weapon_rotation - (temp_accuracy / 2) + (temp_fanseg * i);
	
				draw_vertex(temp_muzzle_x + lengthdir_x(range, temp_fanangle), temp_muzzle_y + lengthdir_y(range, temp_fanangle));
				draw_vertex(temp_muzzle_x, temp_muzzle_y);
				draw_vertex(temp_muzzle_x + lengthdir_x(range, temp_fanangle + temp_fanseg), temp_muzzle_y + lengthdir_y(range, temp_fanangle + temp_fanseg));
			}
			draw_primitive_end();
		}
	}
	else {
		// Draw Line Fan Reticule
		draw_line(temp_muzzle_x, temp_muzzle_y, temp_muzzle_x + lengthdir_x(range, temp_weapon_rotation - (temp_accuracy / 2)), temp_muzzle_y + lengthdir_y(range, temp_weapon_rotation - (temp_accuracy / 2)));
		draw_line(temp_muzzle_x, temp_muzzle_y, temp_muzzle_x + lengthdir_x(range + 1, temp_weapon_rotation + (temp_accuracy / 2)), temp_muzzle_y + lengthdir_y(range + 1, temp_weapon_rotation + (temp_accuracy / 2)));
	
		for (var i = 0; i < temp_fantris; i++) {
			var temp_fanangle = temp_weapon_rotation - (temp_accuracy / 2) + (temp_fanseg * i);
			draw_line(temp_muzzle_x + lengthdir_x(range, temp_fanangle), temp_muzzle_y + lengthdir_y(range, temp_fanangle), temp_muzzle_x + lengthdir_x(range, temp_fanangle + temp_fanseg), temp_muzzle_y + lengthdir_y(range, temp_fanangle + temp_fanseg));
		}
	}
}
*/

// Draw the Flash
draw_set_color(c_white);
if (ds_list_size(flash_timer) > 0) {
	// Individual Bullet Flashes
	for (var f = ds_list_size(flash_timer) - 1; f >= 0; f--) {
		// Flash Variables
		var temp_flash_timer = ds_list_find_value(flash_timer, f);
		var temp_flash_length = ds_list_find_value(flash_length, f);
		var temp_flash_direction = ds_list_find_value(flash_direction, f);
		var temp_flash_xposition = ds_list_find_value(flash_xposition, f);
		var temp_flash_yposition = ds_list_find_value(flash_yposition, f);
		var temp_flash_imageindex = ds_list_find_value(flash_imageindex, f);
	
		// Draw Bullet Trail
		draw_set_alpha(0.4 * (1 - power(((flash_delay - temp_flash_timer) / flash_delay), 2)));
		draw_line(temp_flash_xposition, temp_flash_yposition, temp_flash_xposition + lengthdir_x(temp_flash_length, temp_flash_direction), temp_flash_yposition + lengthdir_y(temp_flash_length, temp_flash_direction));
	
		// Draw Bullet Trail Muzzle Flash
		draw_set_alpha(1);
		if (muzzle_flash_sprite != noone) {
			draw_sprite_ext(muzzle_flash_sprite, temp_flash_imageindex, temp_flash_xposition, temp_flash_yposition, 1, (1 - power(((flash_delay - temp_flash_timer) / flash_delay), 3)) * weapon_yscale, temp_flash_direction, c_white, 1);
		}
	}
	
	// Gun Muzzle Flash
	//draw_sprite_ext(muzzle_flash_sprite, muzzle_flash_index, temp_muzzle_x, temp_muzzle_y, inverse_smooth_lerp(power((temp_flash_timer / flash_delay), 2)), weapon_yscale, temp_weapon_rotation, c_white, 1);
}

// Draw the Firearm
draw_sprite_ext(weapon_sprite, image_index, temp_x, temp_y, weapon_xscale, weapon_yscale, temp_weapon_rotation, c_white, 1);

// Reset Draw Event
draw_set_alpha(1);
draw_set_color(c_white);