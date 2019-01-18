/// checkArrayForValue(array, value);
/// @description Returns true or false depending on if the array contains the given value
/// @param {array} array The given array to check if it contains the given value
/// @param {real} value The value to check the array for
/// @returns {boolean} Returns if the value is contained in the array or not

// Establish Variables
var temp_array = argument0;
var temp_value = argument1;

// Check for value in the array
for (var i = 0; i < array_length_1d(temp_array); i++) {
	if (temp_array[i] == temp_value) {
		return true;
	}
}

return false;