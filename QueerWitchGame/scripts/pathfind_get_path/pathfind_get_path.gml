/// pathfind_get_path(start_x_position, start_y_position, end_x_position, end_y_position);
/// @description Finds the path of least resistance between the start coordinate and the end coordinate
/// @param {real} start_x_position The X position in the world to start pathfinding from
/// @param {real} start_y_position The Y position in the world to start pathfinding from
/// @param {real} end_x_position The X position in the world to end the path at
/// @param {real} end_x_position The Y position in the world to end the path at
/// @returns {array} An array of nodes from the start coordinate to the end coordinate

// Establish Variables
var temp_start_x = argument0;
var temp_start_y = argument1;

var temp_end_x = argument2;
var temp_end_y = argument3;

// Find Edge Data for Start and End Coordinates
var temp_start_edge_data = pathfind_get_closest_point(temp_start_x, temp_start_y);
var temp_end_edge_data = pathfind_get_closest_point(temp_end_x, temp_end_y);

// Check if Edge Data is Viable
if (temp_start_edge_data[2] == noone or temp_start_edge_data[2] == noone) {
	// Edges Don't Exist
	return noone;
}

if (temp_start_edge_data[2] == temp_end_edge_data[2]) {
	// Same Edge
	var temp_early_return = noone;
	temp_early_return[0, 0] = temp_start_edge_data[2];
	temp_early_return[0, 1] = temp_start_edge_data[0];
	temp_early_return[0, 2] = temp_start_edge_data[1];
	temp_early_return[1, 0] = temp_end_edge_data[2];
	temp_early_return[1, 1] = temp_end_edge_data[0];
	temp_early_return[1, 2] = temp_end_edge_data[1];
	return temp_early_return;
}

// Find Nearest Nodes
var temp_start_node = temp_start_edge_data[2].nodes[0];
var temp_start_node_a_distance = point_distance(temp_start_x, temp_start_y, temp_start_edge_data[2].nodes[0].x, temp_start_edge_data[2].nodes[0].y);
var temp_start_node_b_distance = point_distance(temp_start_x, temp_start_y, temp_start_edge_data[2].nodes[1].x, temp_start_edge_data[2].nodes[1].y);
if (temp_start_node_b_distance < temp_start_node_a_distance) {
	temp_start_node = temp_start_edge_data[2].nodes[1];
}

var temp_end_node = temp_end_edge_data[2].nodes[0];
var temp_end_node_a_distance = point_distance(temp_end_x, temp_end_y, temp_end_edge_data[2].nodes[0].x, temp_end_edge_data[2].nodes[0].y);
var temp_end_node_b_distance = point_distance(temp_end_x, temp_end_y, temp_end_edge_data[2].nodes[1].x, temp_end_edge_data[2].nodes[1].y);
if (temp_end_node_b_distance < temp_end_node_a_distance) {
	temp_end_node = temp_end_edge_data[2].nodes[1];
}

// Establish Path
var temp_path_array = pathfind_recursive(noone, temp_start_node, temp_end_node);

// Clean Path
if (array_length_1d(temp_path_array) > 1) {
	var temp_remove_first_index = 0;
	if (temp_path_array[0] == temp_start_edge_data[2].nodes[0]) {
		if (temp_path_array[1] == temp_start_edge_data[2].nodes[1]) {
			temp_remove_first_index = 1;
		}
	}
	else if (temp_path_array[0] == temp_start_edge_data[2].nodes[1]) {
		if (temp_path_array[1] == temp_start_edge_data[2].nodes[0]) {
			temp_remove_first_index = 1;
		}
	}
	
	var temp_remove_last_index = array_length_1d(temp_path_array);
	if (temp_path_array[array_length_1d(temp_path_array) - 1] == temp_end_edge_data[2].nodes[0]) {
		if (temp_path_array[array_length_1d(temp_path_array) - 2] == temp_end_edge_data[2].nodes[1]) {
			temp_remove_last_index = array_length_1d(temp_path_array) - 1;
		}
	}
	else if (temp_path_array[array_length_1d(temp_path_array) - 1] == temp_end_edge_data[2].nodes[1]) {
		if (temp_path_array[array_length_1d(temp_path_array) - 2] == temp_end_edge_data[2].nodes[0]) {
			temp_remove_last_index = array_length_1d(temp_path_array) - 1;
		}
	}
	
	var temp_cutoff_index = 0;
	var temp_cutoff_array = noone;
	for (var q = temp_remove_first_index; q < temp_remove_last_index; q++) {
		temp_cutoff_array[temp_cutoff_index] = temp_path_array[q];
		temp_cutoff_index++;
	}
	
	temp_path_array = temp_cutoff_array;
}

// Assemble Path Data
var temp_return = noone;
temp_return[0, 0] = temp_start_edge_data[2];
temp_return[0, 1] = temp_start_edge_data[0];
temp_return[0, 2] = temp_start_edge_data[1];

for (var k = 0; k < array_length_1d(temp_path_array); k++) {
	var temp_array_height = array_height_2d(temp_return);
	temp_return[temp_array_height, 0] = temp_path_array[k];
	temp_return[temp_array_height, 1] = temp_path_array[k].x_position;
	temp_return[temp_array_height, 2] = temp_path_array[k].y_position;
}

var temp_array_height_again = array_height_2d(temp_return);
temp_return[temp_array_height_again, 0] = temp_end_edge_data[2];
temp_return[temp_array_height_again, 1] = temp_end_edge_data[0];
temp_return[temp_array_height_again, 2] = temp_end_edge_data[1];

return temp_return;
