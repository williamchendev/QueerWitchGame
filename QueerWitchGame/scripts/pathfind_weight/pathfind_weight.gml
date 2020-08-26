/// pathfind_weight(path_array);
/// @description Finds the path of least resistance between the start node and end node with an array of traveled nodes
/// @param {real} path_array
/// @returns {real} An array of nodes


var temp_path_array = argument0;

var temp_weight = 0;
for (var p = 0; p < array_length_1d(temp_path_array) - 1; p++) {
	var temp_weight_edges_array = temp_path_array[p].edges;
	for (var q = 0; q < array_length_1d(temp_weight_edges_array); q++) {
		var temp_weight_edge = temp_weight_edges_array[q];
		if (temp_weight_edge.nodes[0] == temp_path_array[p + 1]) {
			temp_weight += temp_weight_edge.distance;
			break;
		}
		else if (temp_weight_edge.nodes[1] == temp_path_array[p + 1]) {
			temp_weight += temp_weight_edge.distance;
			break;
		}
	}
}

return temp_weight;