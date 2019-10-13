/// inverse_smooth_lerp(value)
/// @description Takes a value between 0 and 1 and finds the inverse smooth lerp
/// @param {real} value The value to find the inverse x smooth lerp of
/// @returns {real} inverse The inverse x smooth lerp of the value

// Establish Variables
var temp_value = clamp(argument0, 0, 1);

// Calculate the Smooth Lerp
temp_value = (1 / ((temp_value * 2) - 2.7)) + 1.6;

// Return Value
return clamp(temp_value, 0, 1);