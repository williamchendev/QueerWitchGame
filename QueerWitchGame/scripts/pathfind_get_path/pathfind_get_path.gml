/// pathfind_get_path(path_array, start_node, end_node);
/// @description Finds the path of least resistance between the start node and end node with an array of traveled nodes
/// @param {real} path_array
/// @param {real} start_node
/// @param {real} end_node
/// @returns {real} An array of nodes

// Establish Variables
var temp_array = argument0;
var temp_start_node = argument1;
var temp_end_node = argument2;

// Index Start Node in Path Array
temp_array[array_length_1d(temp_array)] = temp_start_node;
if (temp_start_node == temp_end_node) {
	return temp_array;
}

// Iterate Through Edges
var temp_return = noone;
var temp_return_weight = 0;
for (var i = 0; i < array_length_1d(temp_start_node.edges); i++) {
	// Establish Edge & Other Node
	var temp_edge = temp_start_node.edges[i];
	var temp_other_node = temp_edge.nodes[0];
	if (temp_edge.nodes[0] == temp_start_node) {
		temp_other_node = temp_edge.nodes[1];
	}
	
	// Check if Exists in Array
	var temp_node_present = false;
	for (var q = 0; q < array_length_1d(temp_array); q++) {
		if (temp_array[q] == temp_other_node) {
			temp_node_present = true;
			break;
		}
	}
	
	// Return Array
	if (!temp_node_present) {
		var temp_path_array = pathfind_get_path(temp_array, temp_other_node, temp_end_node);
		if (temp_path_array != noone) {
			if (temp_return != noone) {
				// Compare Arrays
				var temp_weight = pathfind_weight(temp_path_array);
				if (temp_weight < temp_return_weight) {
					// Set Return Array
					temp_return = temp_path_array;
					temp_return_weight = temp_weight;
				}
			}
			else {
				// Set Return Array
				temp_return = temp_path_array;
				temp_return_weight = pathfind_weight(temp_return);
			}
		}
	}
}

return temp_return;