/// pathfind_get_node_edge(start_node, end_node);
/// @description Searches the start_node for the edge that connects it to the given end_node
/// @param {real} start_node The oPathNode Object Instance ID to search through
/// @param {real} end_node The oPathNode Object Instance ID to search for
/// @returns {real} oPathEdge Object Instance ID that connects the two given nodes (otherwise noone)

// Establish Variables
var temp_start_node = argument0;
var temp_end_node = argument1;

// Search for Edge
var temp_edge = noone;
for (var q = 0; q < array_length_1d(temp_start_node.edges); q++) {
	// Compare Edges
	if (temp_start_node.edges[q].nodes[0] == temp_end_node) {
		// Set Edge & Break
		temp_edge = temp_start_node.edges[q];
		break;
	}
	else if (temp_start_node.edges[q].nodes[1] == temp_end_node) {
		// Set Edge & Break
		temp_edge = temp_start_node.edges[q];
		break;
	}
}

// Return Edge
return temp_edge;