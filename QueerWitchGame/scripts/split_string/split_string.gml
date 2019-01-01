/// split_string(string, delimiter);
/// @description Splits a string based on the delimiter and returns it as a list
/// @param {string} string The string to split
/// @param {string} delimiter The delimiter to split the string by
/// @returns {string} Returns an array of strings split from the given string

// Establish Variables
var temp_string = argument0;
var temp_delimiter = argument1;

// Split String
var temp_array_length = 0;
var temp_return_array;
temp_return_array[temp_array_length] = "";

for (var i = 0; i < string_length(temp_string); i++) {
	var temp_char = string_char_at(temp_string, i + 1);
	if (temp_char == temp_delimiter) {
		temp_array_length++;
		temp_return_array[temp_array_length] = "";
	}
	else {
		temp_return_array[temp_array_length] += temp_char;
	}
}

return temp_return_array;