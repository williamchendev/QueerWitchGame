/// pathfind_get_closest_point_edge(x_position, y_position, start_node, end_node);
/// @description Finds the closest coordinate between the two given oPathNode Nodes from the given position
/// @param {real} x_position The X position to check for the closest coordinate to
/// @param {real} y_position The Y position to check for the closest coordinate to
/// @param {real} start_node The oPathNode to draw an edge towards the end_node
/// @param {real} end_node The oPathNode to draw an edge towards the start_node
/// @returns {array} An array with the X coordinate [0] and Y coordinate [1]

// Establish Variables
var temp_x = argument0;
var temp_y = argument1;
var temp_start_node = argument2;
var temp_end_node = argument3;

// Find Closest Node
var temp_node_a = temp_start_node;
var temp_node_b = temp_end_node;
if (point_distance(temp_x, temp_y, temp_node_b.x, temp_node_b.y) < point_distance(temp_x, temp_y, temp_node_a.x, temp_node_a.y)) {
	temp_node_a = temp_end_node;
	temp_node_b = temp_start_node;
}

// Check if Obtuse
var temp_length_a = point_distance(temp_x, temp_y, temp_node_b.x, temp_node_b.y);
var temp_length_b = point_distance(temp_x, temp_y, temp_node_a.x, temp_node_a.y);
var temp_length_c = point_distance(temp_node_a.x, temp_node_a.y, temp_node_b.x, temp_node_b.y);

var temp_value = (sqr(temp_length_b) + sqr(temp_length_c) - sqr(temp_length_a)) / (2 * temp_length_b * temp_length_c);
temp_value = clamp(temp_value, -0.99, 0.99);
if (is_nan(temp_value)) {
	temp_value = 0;
}
temp_value = round(arccos(temp_value));
if (temp_value >= pi / 2) {
	var temp_obtuse_return_array = noone;
	temp_obtuse_return_array[0] = temp_node_a.x;
	temp_obtuse_return_array[1] = temp_node_a.y;
	return temp_obtuse_return_array;
}

// Calculate Closest Point
var temp_edge_length = cos(temp_value) * temp_length_b;
var temp_edge_angle = point_direction(temp_node_a.x, temp_node_a.y, temp_node_b.x, temp_node_b.y);

// Return Coordinate Array
var temp_return = noone;
temp_return[0] = temp_node_a.x + lengthdir_x(temp_edge_length, temp_edge_angle);
temp_return[1] = temp_node_a.y + lengthdir_y(temp_edge_length, temp_edge_angle);
return temp_return;

/*
// Find Edge Direction & Distance
var temp_edge_distance = point_distance(temp_start_node.x, temp_start_node.y, temp_end_node.x, temp_end_node.y);
var temp_edge_direction = point_direction(temp_start_node.x, temp_start_node.y, temp_end_node.x, temp_end_node.y);

// Find Closest Point on Edge
var temp_closest_x = temp_start_node.x;
var temp_closest_y = temp_start_node.y;
var temp_closest_distance = point_distance(temp_x, temp_y, temp_closest_x, temp_closest_y);

var temp_interpolate = 1;
for (var i = 0; i < temp_edge_distance; i += temp_interpolate) {
	// Find next point in Edge
	var temp_new_x = temp_start_node.x + lengthdir_x(i, temp_edge_direction);
	var temp_new_y = temp_start_node.y + lengthdir_y(i, temp_edge_direction);
	var temp_new_distance = point_distance(temp_x, temp_y, temp_new_x, temp_new_y);
	
	// Compare Distances
	if (temp_new_distance < temp_closest_distance) {
		temp_closest_x = temp_new_x;
		temp_closest_y = temp_new_y;
		temp_closest_distance = temp_new_distance;
	}
}

// Create Return Array
var temp_return_array = noone;
temp_return_array[0] = temp_closest_x;
temp_return_array[1] = temp_closest_y;

// Return Coordinates in Array
return temp_return_array;
*/