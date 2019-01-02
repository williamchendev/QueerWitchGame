/// removeItemInventory(inventory_object, item_id, item_stacks);
/// @description Removes the stack of an item in the given inventory object's inventory array with the given item id and stack
/// @param {real} inventory_object The given inventory object to remove the item from
/// @param {integer} item_id The ID of the item's data index to remove from the inventory array
/// @param {integer} item_stack The stack (or number of items) of the item to be removed from the inventory, the default is 1, this is an optional overloaded argument

// Establish the Variables
var temp_inventory_obj = argument[0];
var temp_item_id = argument[1];
var temp_item_stacks = 1;
if (argument_count == 3) {
	temp_item_stacks = argument[2];
}

// Remove Item from Inventory
for (var h = 0; h < temp_inventory_obj.inventory_height; h++) {
	for (var w = 0; w < temp_inventory_obj.inventory_width; w++) {
		if (temp_item_stacks > 0) {
			if (temp_inventory_obj.inventory[w, h] == temp_item_id) {
				var temp_delete_stack = clamp(temp_inventory_obj.inventory_stacks[w, h], 1, temp_item_stacks);
				temp_inventory_obj.inventory_stacks[w, h] -= temp_delete_stack;
				temp_item_stacks -= temp_delete_stack;
				
				if (temp_inventory_obj.inventory_stacks[w, h] <= 0) {
					var temp_width = global.item_data[temp_inventory_obj.inventory[w, h], itemstats.width_space];
					var temp_height = global.item_data[temp_inventory_obj.inventory[w, h], itemstats.height_space];
					for (var yi = 0; yi < temp_height; yi++) {
						for (var xi = 0; xi < temp_width; xi++) {
							temp_inventory_obj.inventory[w + xi, h + yi] = 0;
						}
					}
				}
			}
		}
		else {
			return;
		}
	}
}