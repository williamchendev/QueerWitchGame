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

var temp_muzzle_x = temp_x + lengthdir_x(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);
var temp_muzzle_y = temp_y + lengthdir_y(temp_muzzle_distance, temp_weapon_rotation + temp_muzzle_direction);

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

// Draw the Attack
draw_set_color(c_white);
if (ds_list_size(flash_timer) > 0 and attack_show) {
	// Check Shader
	var temp_shader = shader_current();
	if (temp_shader != -1) {
		shader_reset();
	}
	
	// Individual Bullet Flashes
	for (var f = ds_list_size(flash_timer) - 1; f >= 0; f--) {
		// Flash Variables
		var temp_flash_timer = ds_list_find_value(flash_timer, f);
		var temp_flash_length = ds_list_find_value(flash_length, f);
		var temp_flash_direction = ds_list_find_value(flash_direction, f);
		var temp_flash_xposition = ds_list_find_value(flash_xposition, f);
		var temp_flash_yposition = ds_list_find_value(flash_yposition, f);
		var temp_flash_imageindex = ds_list_find_value(flash_imageindex, f);
	
		// Check Draw Mode
		if (temp_shader == -1) {
			// Draw Bullet Trail
			draw_set_alpha(0.4 * (1 - power(((flash_delay - temp_flash_timer) / flash_delay), 2)));
			draw_line(temp_flash_xposition, temp_flash_yposition, temp_flash_xposition + lengthdir_x(temp_flash_length, temp_flash_direction), temp_flash_yposition + lengthdir_y(temp_flash_length, temp_flash_direction));
	
			// Draw Bullet Trail Muzzle Flash
			draw_set_alpha(1);
			if (muzzle_flash_sprite != noone) {
				draw_sprite_ext(muzzle_flash_sprite, temp_flash_imageindex, temp_flash_xposition, temp_flash_yposition, 1, (1 - power(((flash_delay - temp_flash_timer) / flash_delay), 3)) * weapon_yscale, temp_flash_direction, c_white, 1);
			}
		}
		else {
			// Draw Knockout
			draw_set_alpha(1);
			draw_set_color(c_black);
			if (muzzle_flash_sprite != noone) {
				draw_sprite_ext(muzzle_flash_sprite, temp_flash_imageindex, temp_muzzle_x, temp_muzzle_y, 1, (1 - power(((flash_delay - temp_flash_timer) / flash_delay), 3)) * weapon_yscale, temp_flash_direction, c_black, 1);
			}
			/*
			draw_line(temp_flash_xposition, temp_flash_yposition, temp_flash_xposition + lengthdir_x(temp_flash_length, temp_flash_direction), temp_flash_yposition + lengthdir_y(temp_flash_length, temp_flash_direction));
			*/
			draw_sprite_ext(sImpact_Blood, hit_effect_index, temp_flash_xposition + lengthdir_x(temp_flash_length + hit_effect_offset, temp_flash_direction), temp_flash_yposition + lengthdir_y(temp_flash_length + hit_effect_offset, temp_flash_direction), hit_effect_xscale, hit_effect_yscale, temp_flash_direction, c_white, 1);
		}
		
		// Reset Shader
		if (temp_shader != -1) {
			shader_set(temp_shader);
		}
	}
}

// Draw the Firearm
draw_sprite_ext(weapon_sprite, image_index, temp_x, temp_y, weapon_xscale, weapon_yscale, temp_weapon_rotation, c_white, 1);

// Draw Debug Firearm Stats
if (global.debug and draw_debug) {
	// Draw Reset Color
	draw_set_alpha(1);
	draw_set_color(c_white);
	
	// Draw Firearm Debug Ranges
	draw_point(temp_muzzle_x, temp_muzzle_y);
	draw_circle(temp_muzzle_x, temp_muzzle_y, close_range_radius, true);
	draw_circle(temp_muzzle_x, temp_muzzle_y, mid_range_radius, true);
	draw_circle(temp_muzzle_x, temp_muzzle_y, far_range_radius, true);
	
	// Draw Firearm Debug Range Hitchances
	draw_set_font(fNormalFont);
	var temp_debug_range_text_offset = 3;
	drawTextOutline(temp_muzzle_x + temp_debug_range_text_offset, temp_muzzle_y, c_white, c_black, string(round(close_range_hit_chance * 100)) + "%");
	drawTextOutline(temp_muzzle_x + close_range_radius + temp_debug_range_text_offset, temp_muzzle_y, c_white, c_black, string(round(mid_range_hit_chance * 100)) + "%");
	drawTextOutline(temp_muzzle_x + mid_range_radius + temp_debug_range_text_offset, temp_muzzle_y, c_white, c_black, string(round(far_range_hit_chance * 100)) + "%");
	drawTextOutline(temp_muzzle_x + far_range_radius + temp_debug_range_text_offset, temp_muzzle_y, c_white, c_black, string(round(sniper_range_hit_chance * 100)) + "%");
}

// Reset Draw Event
draw_set_alpha(1);
draw_set_color(c_white);