/// @description Corn Initialization Event
// creates variables necessary for the corn to be drawn

// Settings
points = 6;
height = 8;
width = 2;
//color = make_color_rgb(236, 205, 104);
//color_dark = make_color_rgb(21, 29, 74);

//color = make_color_rgb(226, 109, 92);
color = make_color_rgb(191, 74, 88);
color_dark = make_color_rgb(94, 11, 21);

max_color_change = 0.2;

complex_physics = true;
lerp_spd = 0.1;

// Stalk Settings
radial_rad = 1.5;
radial_spd = 0.0037;

stalk_lerp_spd = 0.25;
stalk_spd_decay = 0.05;
stalk_max_spd = 10;
stalk_angle_decay = 0.05;
stalk_max_angle = 40;

top_weight = 1.5;
bottom_weight = 0;
vertical_weight_multiplier = 0.4;

// Leaf Settings
leaves_points_max = 3;
leaf_min_length = 5;
leaf_max_length = 8;
radial_leaf_spd = 0.0015;
radial_leaf_displace_min = 5;
radial_leaf_displace_max = 8;

// Tassle Settings
tassle_points = 5;

// Variables
stalk_spd = 0;
stalk_angle = 0;
for (var i = 0; i < points; i++) {
	// Stalk Positional & Movement Variables
	x_origin[i] = x;
	y_origin[i] = y - (height * i);
	
	x_position[i] = x_origin[i];
	y_position[i] = y_origin[i];
	
	x_target[i] = x_origin[i];
	y_target[i] = y_origin[i];
	
	x_displace[i] = 0;
	y_displace[i] = 0;
	
	// Leaves
	leaf_points[i] = irandom_range(1, leaves_points_max);
	if (i == points - 1) {
		leaf_points[i] = tassle_points;
	}
	for (var l = 0; l < leaf_points[i]; l++) {
		// Create angle for leaves
		if (i == points - 1) {
			leaf_origin_angle[i, l] = random_range(-30, 30);
		}
		else {
			if (random_range(0, 9) < 5) {
				leaf_origin_angle[i, l] = random_range(-30, -15);
			}
			else {
				leaf_origin_angle[i, l] = random_range(15, 30);
			}
		}
		leaf_angle[i, l] = leaf_origin_angle[i, l];
		
		// Create Sin values for leaf
		leaf_displace[i, l] = random_range(radial_leaf_displace_min, radial_leaf_displace_max);
		leaf_sin[i, l] = random_range(0.0, 1.0);
		
		// Create length of leaf
		leaf_length[i, l] = random_range(leaf_min_length, leaf_max_length);
		
		// Leaf Positional & Movement Variables
		leaf_x_target[i, l] = lengthdir_x(leaf_length[i, l], 90 + leaf_angle[i, l]);
		leaf_y_target[i, l] = lengthdir_y(leaf_length[i, l], 90 + leaf_angle[i, l]);
		
		leaf_x_position[i, l] = leaf_x_target[i, l];
		leaf_y_position[i, l] = leaf_y_target[i, l];
		
		// Create Leaf color
		var temp_color_change = random_range(-20, 20);
		leaf_color[i, l] = make_color_hsv(color_get_hue(color), color_get_saturation(color) + (temp_color_change * 0.8), color_get_value(color) + temp_color_change);
		leaf_color_merge[i, l] = leaf_color[i, l];
	}
	
	// Sin values
	sin_val[i] = random_range(0.0, 1.0);
	
	// Weights
	point_weight[i] = lerp(bottom_weight, top_weight, i / (points - 1));
}

// Color Variables
color_velocity = 0;
color_change = 0;
stalk_color_a = color;
stalk_color_b = merge_color(color, c_black, 0.15);
stalk_color_c = merge_color(color, c_black, 0.11);

stalk_color_a_merge = color;
stalk_color_b_merge = merge_color(color, c_black, 0.15);
stalk_color_c_merge = merge_color(color, c_black, 0.11);

// Game Manager
game_manager = instance_find(oGameManager, 0);