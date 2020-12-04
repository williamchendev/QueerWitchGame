/// thespian_find(cutscene_object, argument_data);
/// @description Thespian find method, given a text argument to parse and find an entity based on
/// @param {real} cutscene_object The cutscene object handling the cutscene variables/event
/// @param {string} argument_data The argument to parse in string form
/// @returns {real} Returns an entity (object index) based on the given argument

// Assemble Variables
var temp_object = argument0;
var temp_argument = argument1;

// Parse Argument
var temp_arguments = thespian_parse(temp_object, temp_argument);

// Find Behaviour
var temp_return_entity = noone;
if (temp_arguments == noone) {
	// Set Empty Argument to Find Player Unit
	temp_arguments[0] = "unit_player";
}
if (array_length_1d(temp_arguments) == 1) {
	// Find Predefined Units
	switch (temp_arguments[0]) {
		case "unit_player":
			// Return Player Controlled Unit
			for (var q = 0; q < instance_number(oUnitSquad); q++) {
				var temp_search_unit_squad = instance_find(oUnitSquad, q);
				if (temp_search_unit_squad.player_input) {
					temp_return_entity = temp_search_unit_squad;
					break;
				}
			}
			break;
		case "unit":
		case "unit_path":
		case "unit_squad":
			// Random Unit Search Behaviour
			var temp_unit_type = oUnit;
			if (temp_arguments[0] == "unit_path") {
				temp_unit_type = oUnitPath;
			}
			else if (temp_arguments[0] == "unit_squad") {
				temp_unit_type = oUnitSquad;
			}
			
			if (instance_number(temp_unit_type) > 0) {
				temp_return_entity = instance_find(temp_unit_type, irandom(instance_number(temp_unit_type) - 1));
			}
			
			break;
		default:
			// Invalid Statement
			break;
	}
}
else if (array_length_1d(temp_arguments) == 2) {
	// Find Double Arguments
	switch (temp_arguments[0]) {
		case "node":
			// Node Search Behaviour
			for (var q = 0; q < instance_number(oNode); q++) {
				var temp_search_node = instance_find(oNode, q);
				if (temp_search_node.name == temp_arguments[1]) {
					temp_return_entity = temp_search_node;
					break;
				}
			}
			break;
		case "unit":
		case "unit_path":
		case "unit_squad":
			// Unit Search Behaviour
			var temp_unit_type = oUnit;
			if (temp_arguments[0] == "unit_path") {
				temp_unit_type = oUnitPath;
			}
			else if (temp_arguments[0] == "unit_squad") {
				temp_unit_type = oUnitSquad;
			}
			
			if (is_array(temp_arguments[1])) {
				var temp_exclude_array = temp_arguments[1];
				for (var q = 0; q < instance_number(temp_unit_type); q++) {
					var temp_search_unit = instance_find(temp_unit_type, q);
					var temp_unit_excluded = false;
					
					for (var l = 0; l < array_length_1d(temp_exclude_array); l++) {
						if (temp_search_unit == temp_exclude_array[l]) {
							temp_unit_excluded = true;
							break;
						}
					}
					
					if (!temp_unit_excluded) {
						temp_return_entity = temp_search_unit;
						break;
					}
				}
			}
			else if (is_real(temp_arguments[1])) {
				if (instance_number(temp_unit_type) > 0) {
					temp_return_entity = instance_find(temp_unit_type, clamp(round(temp_arguments[1]), 0, instance_number(temp_unit_type) - 1));
				}
			}
			else {
				for (var q = 0; q < instance_number(temp_unit_type); q++) {
					var temp_search_unit = instance_find(temp_unit_type, q);
					if (temp_search_unit.name == temp_arguments[1]) {
						temp_return_entity = temp_search_unit;
						break;
					}
				}
			}
			break;
		default:
			// Invalid Statement
			break;
	}
	
}
return temp_return_entity;