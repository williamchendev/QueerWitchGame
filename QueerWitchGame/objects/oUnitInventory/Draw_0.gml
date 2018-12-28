/// @description Inventory Object Draw Event
// draws the Inventory Object to the screen

// Draws the object only if object mode is active
if (!object_mode) {
	exit;
}

// Draws the inventory object
draw_self();