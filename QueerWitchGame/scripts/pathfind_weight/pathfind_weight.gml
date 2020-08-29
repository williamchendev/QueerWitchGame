/// pathfind_weight(path_array);
/// @description Calculates the weight of a path from an Array of oPathNode Nodes
/// @param {real} path_array The array of oPathNode Nodes
/// @returns {real} The weight of the given path

// Establish Variables
var temp_path_array = argument0;

// Iterate through Nodes & Edges
var temp_weight = 0;
for (var p = 0; p < array_length_1d(temp_path_array) - 1; p++) {
	// Find Node Edge Array
	var temp_weight_edges_array = temp_path_array[p].edges;
	for (var q = 0; q < array_length_1d(temp_weight_edges_array); q++) {
		// Interate through Edge Array & Find Node next in Path
		var temp_weight_edge = temp_weight_edges_array[q];
		if (temp_weight_edge.nodes[0] == temp_path_array[p + 1]) {
			// Add Weight
			temp_weight += temp_weight_edge.distance;
			break;
		}
		else if (temp_weight_edge.nodes[1] == temp_path_array[p + 1]) {
			// Add Weight
			temp_weight += temp_weight_edge.distance;
			break;
		}
	}
}

// Return Weight
return temp_weight;