/// thespian_move(cutscene_object, argument_data);
/// @description Thespian move method, given a text argument to parse and moves entities based on arguments
/// @param {real} cutscene_object The cutscene object handling the cutscene variables/event
/// @param {string} argument_data The argument to parse in string form

// Assemble Variables
var temp_object = argument0;
var temp_argument = argument1;

// Parse Argument
var temp_arguments = thespian_parse(temp_object, temp_argument);

// Move Behaviour
if (array_length_1d(temp_arguments) == 2) {
	// Move Double Arguments
	if (instance_exists(temp_arguments[0]) and instance_exists(temp_arguments[1])) {
		// Check if Instances Exist and are Objects
		if (temp_arguments[0].object_index == oUnitPath or object_is_ancestor(temp_arguments[0].object_index, oUnitPath)) {
			// Unit Path Object Move Behaviour
			temp_arguments[0].path_create = true;
			temp_arguments[0].path_end_x = temp_arguments[1].x;
			temp_arguments[0].path_end_y = temp_arguments[1].y;
		}
	}
}
else if (array_length_1d(temp_arguments) == 3) {
	// Move to given Position
	if (temp_arguments[0].object_index == oUnitPath or object_is_ancestor(temp_arguments[0].object_index, oUnitPath)) {
		if (is_real(temp_arguments[1]) and is_real(temp_arguments[2])) {
			// Unit Path Position Move Behaviour
			temp_arguments[0].path_create = true;
			temp_arguments[0].path_end_x = temp_arguments[1];
			temp_arguments[0].path_end_y = temp_arguments[2];
		}
	}
}