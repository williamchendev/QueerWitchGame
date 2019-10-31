/// @description Corn Update Event
// calculates the position and movement of the corn

// Check if object can be seen by camera
var cam_width = game_manager.camera_width;
var cam_height = game_manager.camera_height;
var cam_x = game_manager.camera_x;
var cam_y = game_manager.camera_y;
if (point_in_rectangle(x, y, cam_x - 5, cam_y, cam_x + cam_width, cam_y + cam_height + ((points + 1) * height))) {
	visible = true;
}
else {
	visible = false;
	exit;
}

// Simple physics check
if (!complex_physics) {
	var physics_obj = collision_line(x, y, x, y - ((points - 1) * height), oPhysics, false, false);
	if (physics_obj != noone) {
		for (i = 0; i < points; i++) {
			var temp_weight = point_weight[i];
			var hspd = physics_obj.hspd * temp_weight;
			var vspd = physics_obj.vspd * (temp_weight * vertical_weight_multiplier);
			x_displace[i] += hspd * 1.2;
			y_displace[i] += vspd + abs(hspd * 0.65);
		}
		stalk_spd += hspd;
	}
}

// Iterate through points on Corn Stalk
for (var i = 0; i < points; i++) {
	// Calculate the sinusoidal math for points
	sin_val[i] += radial_spd;
	if (sin_val[i] > 1) {
		sin_val[i] = 0;
	}
	//var draw_sin = (sin(sin_val[i] * 2 * pi) / 2) + 1;
	
	// Move target points with physics
	if (complex_physics) {
		var physics_obj = instance_position(x_position[i], y_position[i], oPhysics);
		if (physics_obj != noone) {
			var temp_weight = point_weight[i];
			var hspd = physics_obj.hspd * temp_weight;
			var vspd = physics_obj.vspd * (temp_weight * vertical_weight_multiplier);
			x_displace[i] += hspd * 1.2;
			y_displace[i] += vspd + abs(hspd * 0.65);
			stalk_spd += hspd / points;
		}	
	}
	x_displace[i] = lerp(x_displace[i], 0, lerp_spd);
	y_displace[i] = lerp(y_displace[i], 0, lerp_spd);
	
	// Move target points with sinusoidal movements
	var stalk_xposition = x + (sin(degtorad(stalk_angle)) * (i * height));
	var stalk_yposition = y - (sin(degtorad(stalk_angle + 90)) * (i * height));
	x_target[i] = x_origin[i] + x_displace[i] + (cos(sin_val[i] * 2 * pi) * radial_rad);
	y_target[i] = y_origin[i] + y_displace[i] + (sin(sin_val[i] * 2 * pi) * radial_rad);
	x_target[i] = lerp(x_target[i], stalk_xposition, stalk_lerp_spd);
	y_target[i] = lerp(y_target[i], stalk_yposition, stalk_lerp_spd);
	
	// Lerp drawn positions to target
	x_position[i] = lerp(x_position[i], x_target[i], lerp_spd);
	y_position[i] = lerp(y_position[i], y_target[i], lerp_spd);
	
	// Create variables for Corn Leaves
	for (var l = 0; l < leaf_points[i]; l++) {
		// Leaf Sin Variables
		leaf_sin[i, l] += radial_leaf_spd;
		if (leaf_sin[i, l] > 1) {
			leaf_sin[i, l] = 0;
		}
		var draw_leaf_sin = sin(leaf_sin[i, l] * 2 * pi);
		
		// Leaf Angle Variables
		leaf_angle[i, l] = leaf_origin_angle[i, l] + (draw_leaf_sin * leaf_displace[i, l]);
		
		// Calculate target points with sinusoidal movements
		leaf_x_target[i, l] = lengthdir_x(leaf_length[i, l], 90 + leaf_angle[i, l]);
		leaf_y_target[i, l] = lengthdir_y(leaf_length[i, l], 90 + leaf_angle[i, l]);
		
		leaf_x_position[i, l] = lerp(leaf_x_position[i, l], leaf_x_target[i, l], lerp_spd);
		leaf_y_position[i, l] = lerp(leaf_y_position[i, l], leaf_y_target[i, l], lerp_spd);
		
		// Leaf color merge
		leaf_color_merge[i, l] = merge_color(leaf_color[i, l], color_dark, color_velocity);
	}
}

// Stalk angular movement
stalk_spd = clamp(stalk_spd, -stalk_max_spd, stalk_max_spd);
stalk_spd = lerp(stalk_spd, 0, stalk_spd_decay);

stalk_angle = clamp(stalk_angle + stalk_spd, -stalk_max_angle, stalk_max_angle);
stalk_angle = lerp(stalk_angle, 0, stalk_angle_decay);

// Corn color movement
color_velocity = (clamp(abs(stalk_angle) / stalk_max_angle, 0, 1) * max_color_change) + color_change;

stalk_color_a_merge = merge_color(stalk_color_a, color_dark, color_velocity);
stalk_color_b_merge = merge_color(stalk_color_b, color_dark, color_velocity);
stalk_color_c_merge = merge_color(stalk_color_c, color_dark, color_velocity);