/// checkItemUIType(item_id);
/// @description Returns the string index of the proper ui to show based on the given item_id's data
/// @param {integer} item_id The item id to check which proper ui to show
/// @returns {string} Returns the string index of the proper ui to show

// Establish variables
var temp_item_id = argument0;
var temp_item_type = global.item_data[temp_item_id, itemstats.type];
var temp_item_type_index = global.item_data[temp_item_id, itemstats.type_index];

var temp_ui_type = noone;

// Find UI type from item type data
if (temp_item_type = itemtypes.consumable) {
	// Temporary Consumable Data variables
	var temp_consumable_type = global.consumable_data[temp_item_type_index, consumablestats.type];
	//var temp_consumable_strength = global.consumable_data[temp_item_type_index, consumablestats.strength];
	//var temp_status_effects = global.consumable_data[temp_item_type_index, consumablestats.status_effects];
	//var temp_effect_strength = global.consumable_data[temp_item_type_index, consumablestats.effect_strength];
	
	// Check which type to return
	if (temp_consumable_type == consumabletype.heal) {
		temp_ui_type = "health";
	}
	else if (temp_consumable_type == consumabletype.calories) {
		temp_ui_type = "calories";
	}
}

// Return UI type string
return temp_ui_type;