/// @description Pathing Node Initialization Event
// Initializes all the variables and properties of the pathing node

// Node Settings
edges = noone;

x_position = x;
y_position = y;

// Find Node Ground
var temp_ground_y = raycast_ground(x, y, 100);
if (temp_ground_y != noone) {
	y_position = temp_ground_y;
}