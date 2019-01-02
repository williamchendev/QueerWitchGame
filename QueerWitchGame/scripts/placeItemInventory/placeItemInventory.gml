/// placeItemInventory(inventory_object, item_id, item_x, item_y, item_stacks);
/// @description Places an item in the given inventory object's inventory array while formating the other spaces in relation to the given position and size
/// @param {real} inventory_object The given inventory object to place the item
/// @param {integer} item_id The ID of the item's data index to put in the inventory array
/// @param {integer} item_x The starting x coordinate in the inventory array to place the item
/// @param {integer} item_y The starting y coordinate in the inventory array to place the item
/// @param {integer} item_stack The stack of the item to be placed at the item_x and item_y position, this is an optional overloaded argument

// Assemble argument variables
var temp_inventory_obj = argument[0];
var temp_item_id = argument[1];
var temp_x = argument[2];
var temp_y = argument[3];
var temp_width = global.item_data[temp_item_id, itemstats.width_space];
var temp_height = global.item_data[temp_item_id, itemstats.height_space];

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

// Place items stacks if overload method
if (argument_count == 4) {
	temp_inventory_obj.inventory_stacks[temp_x, temp_y] += 1;
}
else if (argument_count == 5) {
	var temp_item_stack = argument[4];
	if (temp_item_stack = -1) {
		temp_item_stack = global.item_data[temp_item_id, itemstats.stack_limit];
	}
	temp_inventory_obj.inventory_stacks[temp_x, temp_y] += temp_item_stack;
}