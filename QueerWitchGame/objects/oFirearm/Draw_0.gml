/// @description Firearm Draw
// Draws the firearm object to the screen

// Weapon Rotation
var temp_weapon_rotation = weapon_rotation + recoil_angle_shift;

// Calculate Weapon Range & Accuracy
var temp_muzzle_direction = point_direction(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);
var temp_muzzle_distance = point_distance(0, 0, muzzle_x * weapon_xscale, muzzle_y * weapon_yscale);

var temp_muzzle_x = x + lengthdir_x(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
var temp_muzzle_y = y + lengthdir_y(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);

var temp_accuracy = clamp((accuracy - accuracy_peak) * (1 - aim), 0, 360 - accuracy_peak) + accuracy_peak;

if (temp_accuracy - 1 > accuracy_peak) {
	draw_set_alpha(clamp(0.5 * power(aim, 3), 0.06, 0.5));
	draw_set_color(c_black);
}
else {
	draw_set_alpha(0.3);
	draw_set_color(c_white);
}

// Draw Aim Fan Reticule
var temp_fanlength = (pi * (range * 2)) * (temp_accuracy / 360);
var temp_fantris = floor(temp_fanlength / clamp(temp_accuracy, 1, 10));
var temp_fanseg = (temp_accuracy / temp_fantris);

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

// Draw the Flash
if (flash_timer > 0) {
	draw_set_alpha(0.3);
	draw_set_color(c_white);
	draw_line(temp_muzzle_x, temp_muzzle_y, temp_muzzle_x + lengthdir_x(range, flash_direction), temp_muzzle_y + lengthdir_y(range, flash_direction));
}

// Draw the Firearm
draw_sprite_ext(weapon_sprite, image_index, x, y, weapon_xscale, weapon_yscale, temp_weapon_rotation, c_white, 1);

// Reset Draw Event
draw_set_alpha(1);
draw_set_color(c_white);