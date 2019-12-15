/// addItemInventory(inventory_object, item_id, item_stacks);
/// @description Places an item in the given inventory object's inventory array given it's size and it's item stacks and returns the amount of stacks remaining
/// @param {real} inventory_object The given inventory object to place the item
/// @param {integer} item_id The ID of the item's data index to put in the inventory array
/// @param {integer} item_stack The stack of the item to be placed at the item_x and item_y position, by default this number is one, this is an optional overloaded argument
/// @returns {integer} Returns the remaining amount of stacks of the item if they were not able to be placed

// Establish the Variables
var temp_inventory_obj = argument[0];
var temp_inventory_width = temp_inventory_obj.inventory_width;
var temp_inventory_height = temp_inventory_obj.inventory_height;

var temp_item_id = argument[1];
var temp_item_width = global.item_data[temp_item_id, itemstats.width_space];
var temp_item_height = global.item_data[temp_item_id, itemstats.height_space];
var temp_item_stack = 1;
var temp_item_stack_limit = global.item_data[temp_item_id, itemstats.stack_limit];
if (argument_count == 3) {
	temp_item_stack = argument[2];
}

// Check for places to place item stack while stack is greater than 0
for (var h = 0; h < temp_inventory_height; h++) {
	for (var w = 0; w < temp_inventory_width; w++) {
		if (temp_item_stack > 0) {
			if (checkItemInventory(temp_inventory_obj, w, h, temp_item_width, temp_item_height, temp_item_id)) {
				 var temp_can_place_num = clamp(temp_item_stack, 1, temp_item_stack_limit - temp_inventory_obj.inventory_stacks[w, h]);
				 placeItemInventory(temp_inventory_obj, temp_item_id, w, h, temp_can_place_num);
				 temp_item_stack -= temp_can_place_num;
				 
				 if (global.item_data[temp_item_id, itemstats.type] == itemtypes.weapon) {
					 if (temp_can_place_num > 0) {
						 ds_list_add(temp_inventory_obj.weapons, instance_create_layer(x, y, layer_get_id("Instances"), global.weapon_data[global.item_data[temp_item_id, itemstats.type_index], weaponstats.object]));
						 ds_list_add(temp_inventory_obj.weapons_index, (temp_inventory_width * h) + w);
					 }
				 }
			}
		}
		else {
			return 0;
		}
	}
}

// Return remaining stack
return temp_item_stack;