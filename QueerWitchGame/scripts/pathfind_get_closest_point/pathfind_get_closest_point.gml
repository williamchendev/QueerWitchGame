/// pathfind_get_closest_point(x_position, y_position);
/// @description Finds the closest coordinate that exists on any oPathEdge that exists in the room
/// @param {real} x_position The X position to check for the closest coordinate to on a oPathEdge
/// @param {real} y_position The Y position to check for the closest coordinate to on a oPathEdge
/// @returns {array} An array with the X coordinate [0] and Y coordinate [1] and the oPathEdge it exists on [2]

// Establish Variables
var temp_x = argument0;
var temp_y = argument1;

// Closest Edge Variables
var temp_edge_x = 0;
var temp_edge_y = 0;
var temp_closest_edge = noone;

// Iterate Through Edges
for (var i = 0; i < instance_number(oPathEdge); i++) {
	// Find Next Edge & Closest Point on Edge
	var temp_next_edge = instance_find(oPathEdge, i);
	var temp_next_edge_coord = pathfind_get_closest_point_edge(temp_x, temp_y, temp_next_edge.nodes[0], temp_next_edge.nodes[1]);
	var temp_next_edge_x = temp_next_edge_coord[0];
	var temp_next_edge_y = temp_next_edge_coord[1];
	
	// Compare Edge Distances
	if (point_distance(temp_x, temp_y, temp_next_edge_x, temp_next_edge_y) < point_distance(temp_x, temp_y, temp_edge_x, temp_edge_y) or (temp_closest_edge == noone)) {
		temp_closest_edge = temp_next_edge;
		temp_edge_x = temp_next_edge_x;
		temp_edge_y = temp_next_edge_y;
	}
}

// Return Array Variables
var temp_return_array = noone;
temp_return_array[0] = temp_edge_x;
temp_return_array[1] = temp_edge_y;
temp_return_array[2] = temp_closest_edge;

// Return Array
return temp_return_array;