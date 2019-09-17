/// string_digitsdecimal(string);
/// @description Parses a string and returns a real from the digits and decimal
/// @param {string} string The string to parse into a real
/// @returns {real} Returns a real from the digits and decimal in the parsed string

// Function Variables
var temp_parse_string = argument0;
show_debug_message(temp_parse_string);

// Permitted Characters
var temp_characters = "0123456789.-";

// Parse String for Real
var temp_real_raw = "";
for (var i = 0; i < string_length(temp_parse_string) + 1; i++) {
	// Parse by Characters
	var temp_char = string_copy(temp_parse_string, i, 1);
	
	// Check if Char Matches
	if (string_pos(temp_char, temp_characters) != 0) {
		temp_real_raw += temp_char;
	}
}

// Return Real
return real(temp_real_raw);