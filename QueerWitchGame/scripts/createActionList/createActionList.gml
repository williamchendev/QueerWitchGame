/// createActionList(unit_object);
/// @description Returns a list of valid, non-repeating, action type, item id's from a given unit object and it's inventory data and name
/// @param {real} unit_object The unit object to get a name and inventory data from
/// @returns {array} A list of action id's from the given unit object's data

// Establish Variables
var temp_unit = argument0;
var temp_unit_name = temp_unit.name;
var temp_inventory_obj = temp_unit.unit_inventory;
var temp_inventory_width = temp_inventory_obj.inventory_width;
var temp_inventory_height = temp_inventory_obj.inventory_height;

// Create List of Items
var i = 0;
var temp_actions_list = noone;

for (var h = 0; h < temp_inventory_height; h++) {
	for (var w = 0; w < temp_inventory_width; w++) {
		// Check if inventory index is an item id
		if (temp_inventory_obj.inventory[w, h] > 0) {
			// Create temporary variables for item id and item type
			var temp_item_id = temp_inventory_obj.inventory[w, h];
			var temp_item_type = global.item_data[temp_item_id, itemstats.type];
			
			// If item is already in the action list skip item
			if (check_array_value(temp_actions_list, temp_item_id)) {
				continue;
			}
			
			// Check criteria of item as an action based on type
			if (temp_item_type == itemtypes.consumable) {
				// Create temporary consumable variables for consumable id, unit whitelist, and unit blacklist
				var temp_consumable_id = global.item_data[temp_item_id, itemstats.type_index];
				var temp_consumable_whitelist = global.consumable_data[temp_consumable_id, consumablestats.users_whitelist];
				var temp_consumable_blacklist = global.consumable_data[temp_consumable_id, consumablestats.users_blacklist];
				
				// Check Unit Consumable criteria
				if (temp_consumable_whitelist != noone) {
					// Check if unit is on the whitelist if whitelist exists
					var temp_canuse = false;
					for (var q = 0; q < array_length_1d(temp_consumable_whitelist); q++) {
						if (temp_consumable_whitelist[q] == temp_unit_name) {
							temp_canuse = true;
							break;
						}
					}
					
					if (!temp_canuse) {
						continue;
					}
				}
				if (temp_consumable_blacklist != noone) {
					// Check if unit is on the blacklist if blacklist exists
					var temp_canuse = true;
					for (var q = 0; q < array_length_1d(temp_consumable_whitelist); q++) {
						if (temp_consumable_whitelist[q] == temp_unit_name) {
							temp_canuse = false;
							break;
						}
					}
					
					if (!temp_canuse) {
						continue;
					}
				}
				
				// If criteria is met add item id to the action list and increment up
				temp_actions_list[i] = temp_inventory_obj.inventory[w, h];
				i++;
			}
			else if (temp_item_type == itemtypes.weapon) {
				// If criteria is met add item id to the action list and increment up
				temp_actions_list[i] = temp_inventory_obj.inventory[w, h];
				i++;
			}
		}
	}
}

// Return the list of action item id's
/*
for (var i = 0; i < 24; i++) {
	temp_actions_list[i] = temp_inventory_obj.inventory[0, 0];
}
*/
return temp_actions_list;