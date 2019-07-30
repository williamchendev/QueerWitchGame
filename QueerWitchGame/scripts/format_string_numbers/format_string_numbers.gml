/// format_string_numbers(string, length);
/// @description Formats a string to the provided length using additional spaces
/// @param {string} string The desired string to format
/// @param {real} length The length of the new string in characters
/// @returns {string} Returns a string of the desired length

// Establish Variables
var temp_string = argument0;
var temp_length = argument1;

var temp_line = "";

for (var i = 0; i < temp_length - string_length(temp_string); i++) {
	temp_line += " ";
}

return temp_line + temp_string;