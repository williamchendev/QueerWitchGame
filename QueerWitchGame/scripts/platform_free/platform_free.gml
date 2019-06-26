/// platform_free(x,y,platform_list);
/// @description Checks if the object will collide with any platforms and solids at the given position
/// @param {real} x The x position to check
/// @param {real} y The y position to check
/// @param {ds_list} platform_list The ds_list of platform object id's
/// @returns {boolean} returns true if location is empty of solids and the list of platform instances

// Variables
var temp_x = argument0;
var temp_y = argument1;
var temp_platform_list = argument2;

// Check if touching a solid
if (!place_free(temp_x, temp_y)) {
	return false;
}

// Check if touching a platform
for (var i = 0; i < ds_list_size(temp_platform_list); i++) {
	var temp_platform = ds_list_find_value(temp_platform_list, i);
	if (!place_empty(temp_x, temp_y, temp_platform)) {
		return false;
	}
}

return true;