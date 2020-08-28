/// raycast_ground(x,y,raycast_length);
/// @description Raycasts a line down from the given coordinate for as long as the raycast length to check for a platform or a solid
/// @param {real} x The x position of the raycast to check downwards from
/// @param {real} y The y position of the raycast to check downwards from
/// @param {real} raycast_length The length of the raycast to check downwards from
/// @returns {real} The y position in the world where the raycast collided with a platform object or a solid object (returns noone if did not contact anything)


// Establish Variables
var temp_start_x = argument0;
var temp_start_y = argument1;
var temp_raycast_length = argument2;

// Check for Nearest Viable Platform
var temp_platform_y = temp_start_y;
var temp_found_platform = false;
var temp_platform_list = ds_list_create();
var temp_platform_num = collision_line_list(temp_start_x, temp_start_y, temp_start_x, temp_start_y + temp_raycast_length, oPlatform, false, true, temp_platform_list, true);
if (temp_platform_num > 0) {
    for (var i = 0; i < temp_platform_num; i++) {
		var temp_platform = ds_list_find_value(temp_platform_list, i);
		if (temp_platform.y > temp_start_y) {
			temp_platform_y = temp_platform.y;
			temp_found_platform = true;
			break;
		}
    }
}
ds_list_destroy(temp_platform_list);

// Iterate Raycast Towards Ground
var temp_ground_y = 0;
var temp_found_ground = false;
if (position_meeting(temp_start_x, temp_start_y, oSolid)) {
	return noone;
}
for (var i = 0; i < temp_raycast_length; i++) {
	temp_ground_y = temp_start_y + i;
	if (position_meeting(temp_start_x, temp_ground_y, oSolid)) {
		temp_found_ground = true;
		break;
	}
}

// Return Earliest Collision
var temp_y = noone;
if (temp_found_ground and temp_found_platform) {
	temp_y = temp_platform_y;
	if (temp_ground_y < temp_platform_y) {
		temp_y = temp_ground_y;
	}
}
else if (temp_found_ground) {
	temp_y = temp_ground_y;
}
else if (temp_found_platform) {
	temp_y = temp_platform_y;
}

// Return
return temp_y;