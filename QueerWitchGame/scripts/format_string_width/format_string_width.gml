/// format_string_width(string, width);
/// @description Formats a string using new lines based on the given width of the desired string
/// @param {string} string The desired string to format
/// @param {real} width The width of the new string
/// @returns {string} Returns a string of the desired width

// Establish Variables
var temp_string = argument0;
var temp_width = argument1;

// Format string
var temp_split_string = split_string(temp_string, " ");
var temp_line = "";
var temp_return_line = "";

temp_line += temp_split_string[0];
for (var i = 1; i < array_length_1d(temp_split_string); i++) {
	if (string_width(temp_line + temp_split_string[i]) > temp_width) {
		temp_return_line += temp_line + "\n";
		temp_line = temp_split_string[i];
	}
	else {
		temp_line += " " + temp_split_string[i];
	}
}
temp_return_line += temp_line;

/*
for (var i = 0; i < string_length(temp_string); i++) {
	var temp_char = string_char_at(temp_string, i + 1);
	if (temp_line == "\n" and temp_char == " ") {
		continue;
	}
	else {
		temp_line += temp_char;
	}
	
	if (string_width(temp_line) >= temp_width) {
		temp_return_line += temp_line;
		temp_line = "\n";
	}
}

if (temp_line != "\n") {
	temp_return_line += temp_line;
}
*/

return temp_return_line;