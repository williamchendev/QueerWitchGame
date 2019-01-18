/// format_str_int_comma(number);
/// @description Returns a string from the provided integer by placing commas after every 3 places in the integer
/// @param {integer} number The number to format into a string and place commas with
/// @returns {string} Returns a string of the given number but with commas after each place

var temp_number_string = string(argument0);

var i = string_length(string(argument0));
var temp_number_place_count = 0;

while (i > 1) {
	temp_number_place_count++;
	if (temp_number_place_count == 3) {
		temp_number_string = string_insert(",", temp_number_string, i);
		temp_number_place_count = 0;
	}
	i--;
}

return temp_number_string;