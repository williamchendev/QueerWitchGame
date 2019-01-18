/// unitUseConsumable(unit_object, item_id);
/// @description Performs all the calculations for a unit to use a consumable item
/// @param {real} unit_object The Unit object to use the consumable
/// @param {integer} item_id The item id of the consumable the unit object is consuming
/// @returns Returns true or false if the unit is capable of using the consumable

// Establish Variables
var temp_unit = argument0;
var temp_item_id = argument1;

var temp_item_type = global.item_data[temp_item_id, itemstats.type];
var temp_item_type_index = global.item_data[temp_item_id, itemstats.type_index];

// Use Consumable
if (temp_item_type = itemtypes.consumable) {
	// Temporary Consumable Data variables
	var temp_consumable_type = global.consumable_data[temp_item_type_index, consumablestats.type];
	var temp_consumable_strength = global.consumable_data[temp_item_type_index, consumablestats.strength];
	var temp_status_effects = global.consumable_data[temp_item_type_index, consumablestats.status_effects];
	var temp_effect_strength = global.consumable_data[temp_item_type_index, consumablestats.effect_strength];
	
	// Add consumable values to Unit values
	if (temp_consumable_type == consumabletype.heal) {
		if (temp_unit.health_points < temp_unit.max_health_points) {
			temp_unit.health_points = clamp(temp_unit.health_points + temp_consumable_strength, 0, temp_unit.max_health_points);
			return true;
		}
	}
	else if (temp_consumable_type == consumabletype.calories) {
		if (temp_unit.calories < temp_unit.max_calories) {
			temp_unit.calories = clamp(temp_unit.calories + temp_consumable_strength, 0, temp_unit.max_calories);
			return true;
		}
	}
}

return false;