/// countItemInventory(inventory_object, item_id);
/// @description Counts the number items of an item exist the given inventory object's inventory array with the same given item id
/// @param {real} inventory_object The given inventory object to count items in
/// @param {integer} item_id The ID of the item's data index to count in the inventory array
/// @returns {integer} Returns the number of items that have the same item id as the given item id

// Establish the Variables
var temp_inventory_obj = argument0;
var temp_item_id = argument1;
var temp_total = 0;

// Remove Item from Inventory
for (var h = 0; h < temp_inventory_obj.inventory_height; h++) {
	for (var w = 0; w < temp_inventory_obj.inventory_width; w++) {
		if (temp_inventory_obj.inventory[w, h] == temp_item_id) {
			temp_total += temp_inventory_obj.inventory_stacks[w, h];
		}
	}
}

return temp_total;