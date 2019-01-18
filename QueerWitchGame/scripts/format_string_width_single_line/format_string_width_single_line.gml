/// format_string_width_single_line(string, width);
/// @description Formats a string to a single line by removing letters based on the given width of the desired string
/// @param {string} string The desired string to format
/// @param {real} width The width of the new string
/// @returns {string} Returns a string of the desired width

// Establish Variables
var temp_string = argument0;
var temp_width = argument1;

// Format string
var temp_line = "";

for (var i = 1; i <= string_length(temp_string); i++) {
	if (string_width(temp_line + string_char_at(temp_string, i)) > temp_width) {
		return temp_line;
	}
	else {
		temp_line += string_char_at(temp_string, i);
	}
}

return temp_line;