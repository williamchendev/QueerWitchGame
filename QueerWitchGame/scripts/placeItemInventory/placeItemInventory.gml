/// placeItemInventory(inventory_object, item_id, item_x, item_y);
/// @description Places an item in the given inventory object's inventory array while formating the other spaces in relation to the given position and size
/// @param {real} inventory_object The given inventory object to place the item
/// @param {integer} item_id The ID of the item's data index to put in the inventory array
/// @param {integer} item_x The starting x coordinate in the inventory array to place the item
/// @param {integer} item_y The starting y coordinate in the inventory array to place the item

// Assemble argument variables
var temp_inventory_obj = argument0;
var temp_item_id = argument1;
var temp_x = argument2;
var temp_y = argument3;
var temp_width = global.item_data[temp_item_id, 4];
var temp_height = global.item_data[temp_item_id, 5];

// Set formatted spaces in inventory array
var temp_formatted_index = (-1 * (temp_x + (temp_y * temp_inventory_obj.inventory_width))) - 1;
for (var h = 0; h < temp_height; h++) {
	for (var w = 0; w < temp_width; w++) {
		var temp_check_x = temp_x + w;
		var temp_check_y = temp_y + h;
		
		temp_inventory_obj.inventory[temp_check_x, temp_check_y] = temp_formatted_index;
	}
}

// Set Item ID to inventory array space
temp_inventory_obj.inventory[temp_x, temp_y] = temp_item_id;