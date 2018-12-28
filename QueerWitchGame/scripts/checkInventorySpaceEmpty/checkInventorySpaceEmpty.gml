/// checkInventorySpaceEmpty(inventory_object, item_x, item_y, item_width, item_height);
/// @description Checks a given inventory object's inventory data to see if an item can be placed with the given width and height
/// @param {real} inventory_object The given inventory object to check for empty space
/// @param {integer} item_x The starting x coordinate in the inventory array to check for empty space
/// @param {integer} item_y The starting y coordinate in the inventory array to check for empty space
/// @param {integer} item_width The width from the starting x coordinate to check the array for empty space
/// @param {integer} item_height The height from the starting y coordinate to check the array for empty space
/// @returns {boolean} Returns a bool if the inventory has the space for the item with the given position and size of the item

// Assemble argument variables
var temp_inventory_obj = argument0;
var temp_x = argument1;
var temp_y = argument2;
var temp_width = argument3;
var temp_height = argument4;

// Check if the item's size and position are within bounds of the inventory's size
if (temp_x + (temp_width - 1) > temp_inventory_obj.inventory_width - 1) {
	return false;
}
else if (temp_y + (temp_height - 1) > temp_inventory_obj.inventory_height - 1) {
	return false;
}

// Check if each space inside the inventory is empty
for (var h = 0; h < temp_height; h++) {
	for (var w = 0; w < temp_width; w++) {
		var temp_check_x = temp_x + w;
		var temp_check_y = temp_y + h;
		
		if (temp_inventory_obj.inventory[temp_check_x, temp_check_y] != 0) {
			return false;
		}
	}
}

// Return true if all conditions are met
return true;