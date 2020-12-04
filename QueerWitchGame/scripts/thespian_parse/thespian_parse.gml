/// thespian_parse(cutscene_object, argument_data);
/// @description Thespian parse method, takes a given string and parses it into an array of arguments
/// @param {real} cutscene_object The cutscene object handling the cutscene variables/event
/// @param {string} argument_data The argument to parse in string form
/// @returns {string} Returns an array of parsed arguments, Returns noone if argument is empty

// Assemble Variables
var temp_object = argument0;
var temp_argument = argument1;
temp_argument = string_replace_all(temp_argument, "(", "");
temp_argument = string_replace_all(temp_argument, ")", "");

// Parse Argument
var temp_arguments = split_string(temp_argument, ",");
for (var i = 0; i < array_length_1d(temp_arguments); i++) {
	// Check if Argument is a Numbern
	var temp_digits_num = string_length(string_digits(temp_arguments[i]));
	var temp_is_digit = temp_digits_num and temp_digits_num == string_length(temp_arguments[i]) - (string_char_at(temp_arguments[i], 1) == "-") - (string_pos(".", temp_arguments[i]) != 0);
	
	// Parse Argument Behaviour
	if (string_pos("\"", temp_arguments[i]) != 0) {
		temp_arguments[i] = string_replace_all(temp_arguments[i], "\"", "");
	}
	else if (temp_is_digit) {
		temp_arguments[i] = real(temp_arguments[i]);
	}
	else if (!is_undefined(ds_map_find_value(temp_object.cutscene_variables, temp_arguments[i]))) {
		temp_arguments[i] = ds_map_find_value(temp_object.cutscene_variables, temp_arguments[i]);
	}
	else if (temp_arguments[i] == "") {
		return noone;
	}
}

// Return Parsed Arguments
return temp_arguments;