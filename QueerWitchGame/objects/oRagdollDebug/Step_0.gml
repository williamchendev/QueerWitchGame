/// @description Ragdoll Update Event
// Performs the physics calculations for the Ragdoll's Behaviour

// Angular Physics Variables
var temp_collision_points = 0;
var temp_collision_single_point_x = 0;
var temp_collision_single_point_y = 0;
var temp_test_edges = false;

while (temp_collision_points == 0) {
	// Iterate through Collider Vertices
	for (var i = 0; i < array_height_2d(collider_points); i++) {
		// Find Collider Vertice from Center of Mass
		var temp_collision_angle = point_direction(0, 0, collider_points[i, 0], collider_points[i, 1]);
		var temp_collision_distance = point_distance(0, 0, collider_points[i, 0], collider_points[i, 1]);
		var temp_collision_point_x = x + lengthdir_x(temp_collision_distance, temp_collision_angle + image_angle);
		var temp_collision_point_y = y + lengthdir_y(temp_collision_distance, temp_collision_angle + image_angle);

		// Find Second Collider Vertice
		var q = (i + 1) mod (array_height_2d(collider_points));
		var temp_collision_angle_1 = point_direction(0, 0, collider_points[q, 0], collider_points[q, 1]);
		var temp_collision_distance_1 = point_distance(0, 0, collider_points[q, 0], collider_points[q, 1]);
		var temp_collision_point_x_1 = x + lengthdir_x(temp_collision_distance_1, temp_collision_angle_1 + image_angle);
		var temp_collision_point_y_1 = y + lengthdir_y(temp_collision_distance_1, temp_collision_angle_1 + image_angle);
			
		// Iterate Through Points on Collider Edge
		var temp_collision_edge_angle = point_direction(temp_collision_point_x, temp_collision_point_y, temp_collision_point_x_1, temp_collision_point_y_1);
		var temp_collision_edge_distance = point_distance(temp_collision_point_x, temp_collision_point_y, temp_collision_point_x_1, temp_collision_point_y_1);
		for (var l = 0; l < temp_collision_edge_distance; l += collider_edge_interpolation) {
			// Establish Interpolated Point to Check
			var temp_collision_edge_point_x = temp_collision_point_x + lengthdir_x(l, temp_collision_edge_angle);
			var temp_collision_edge_point_y = temp_collision_point_y + lengthdir_y(l, temp_collision_edge_angle);
			temp_collision_edge_point_x += lengthdir_x(collider_edge_check_distance, temp_collision_edge_angle + 90);
			temp_collision_edge_point_y += lengthdir_y(collider_edge_check_distance, temp_collision_edge_angle + 90);
				
			// Check Collisions at Point
			if (collision_point(temp_collision_edge_point_x, temp_collision_edge_point_y, oSolid, true, true)) {
				temp_collision_single_point_x = temp_collision_edge_point_x;
				temp_collision_single_point_y = temp_collision_edge_point_y;
				temp_collision_points++;
			}
		}
	
		// Debug
		//draw_x[i] = temp_collision_point_x;
		//draw_y[i] = temp_collision_point_y;
		//draw_color[i] = c_white;
	
		// Test Collider Vertice
		/*
		if (collision_point(temp_collision_point_x, temp_collision_point_y, oSolid, true, true)) {
			draw_color[i] = c_red;
			temp_collision_single_point_x = temp_collision_point_x;
			temp_collision_single_point_y = temp_collision_point_y;
			temp_collision_points++;
		}
		*/
	}
	
	// Break Loop
	if (temp_test_edges) {
		break;
	}
	temp_test_edges = true;
}

// Angular Vertice Physics
draw_num = temp_collision_points;
if (temp_collision_points == 1) {
	// Establish Previous Orientation Variables
	var temp_old_x = x;
	var temp_old_y = y;
	var temp_old_angle = image_angle;
	
	// Find Gravity Angular Direction from the collision point relative to the center of mass
	var temp_angle_grav_direction = sign(temp_collision_single_point_x - x);
	var temp_angle_grav_spd = temp_angle_grav_direction * global.deltatime;
	
	// Establish New Position from Angle Orientation Variables
	var temp_orientation_angle = point_direction(temp_collision_single_point_x, temp_collision_single_point_y, x, y);
	var temp_orientation_distance = point_distance(temp_collision_single_point_x, temp_collision_single_point_y, x, y);
	x = temp_collision_single_point_x + lengthdir_x(temp_orientation_distance, temp_orientation_angle + temp_angle_grav_spd);
	y = temp_collision_single_point_y + lengthdir_y(temp_orientation_distance, temp_orientation_angle + temp_angle_grav_spd);
	image_angle += temp_angle_grav_spd;
	
	// Check if new position is viable
	/*
	if (!place_free(x, y)) {
		// Reset Position
		x = temp_old_x;
		y = temp_old_y;
		image_angle = temp_old_angle;
	}
	*/
}

// Physics
if (place_free(x, y + 1)) {
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
	if (place_free(x, y + temp_y_velocity)) {
		vspd += temp_y_velocity;
	}
	else {
		for (var i = abs(temp_y_velocity); i > 0; i -= 0.5) {
			if (place_free(x, y + (i * sign(y_velocity)))) {
				vspd += i * sign(y_velocity);
				break;
			}
		}
		y_velocity = 0;
	}
}

x += hspd;
y += vspd;