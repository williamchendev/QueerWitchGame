/// thespian_wait(cutscene_object, argument_data);
/// @description Thespian wait method, given a text argument to parse and pace/wait for given cutscene events
/// @param {real} cutscene_object The cutscene object handling the cutscene variables/event
/// @param {string} argument_data The argument to parse in string form

// Assemble Variables
var temp_object = argument0;
var temp_argument = argument1;

// Parse Argument
var temp_arguments = thespian_parse(temp_object, temp_argument);

// Wait Behaviour
if (temp_arguments == noone) {
	// No Argument Set Wait Text
	temp_object.cutscene_wait = true;
}
else if (array_length_1d(temp_arguments) == 1) {
	// Wait Single Arguments
	if (is_real(temp_arguments[0])) {
		// Set Wait Timer
		temp_object.cutscene_wait = true;
		temp_object.cutscene_wait_timer = temp_arguments[0] * 60;
	}
}
else if (array_length_1d(temp_arguments) == 2) {
	// Wait Double Arguments
	if (instance_exists(temp_arguments[0])) {
		// Instance First Argument
		if (temp_arguments[0].object_index == oUnitPath or object_is_ancestor(temp_arguments[0].object_index, oUnitPath)) {
			// Unit Path Wait Behaviour
			if (temp_arguments[1] == "path") {
				// Set Wait Unit Path
				ds_list_add(temp_object.cutscene_wait_unitpath, temp_arguments[0]);
			}
		}
	}
}