/// @description Insert description here
// You can write your code in this editor

if (place_free(x, y)) {
	image_angle += case_rotation;
	
	var hspd = 0;
	var vspd = 0;
	
	hspd += lengthdir_x(case_spd, case_direction) * (delta_time * 0.00005);
	vspd += lengthdir_y(case_spd, case_direction) * (delta_time * 0.00005);
	
	spd += gravity_spd * (delta_time * 0.00005);
	hspd += lengthdir_x(spd, -90) * (delta_time * 0.00005);
	vspd += lengthdir_y(spd, -90) * (delta_time * 0.00005);
	
	if (!place_free(x + hspd, y + vspd)) {
		var temp_distance = point_distance(x, y, x + hspd, y + vspd);
		var temp_direction = point_direction(x, y, x + hspd, y + vspd);
		for (var i = 0; i < temp_distance; i++) {
			x += lengthdir_x(1, temp_direction);
			y += lengthdir_y(1, temp_direction);
			
			if (!place_free(x, y)) {
				break;
			}
		}
	}
	else {
		x += hspd;
		y += vspd;
	}
}

decay -= (delta_time * 0.00005);
image_alpha = decay / decay_max;
if (decay <= 0) {
	instance_destroy();
}