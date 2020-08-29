/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);

// Establish Variables
var temp_start_x = mouse_x;
var temp_start_y = mouse_y;
var temp_raycast_length = 100;

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
for (var i = 0; i < temp_raycast_length; i++) {
	temp_ground_y = temp_start_y + i;
	if (position_meeting(temp_start_x, temp_ground_y, oSolid)) {
		temp_found_ground = true;
		break;
	}
}

// Return Earliest Collision
var temp_y = temp_platform_y;
if (temp_found_ground and temp_found_platform) {
	if (temp_ground_y < temp_platform_y) {
		temp_y = temp_ground_y;
	}
}
else if (temp_found_ground) {
	temp_y = temp_ground_y;
}

draw_line(temp_start_x, temp_start_y, temp_start_x, temp_y);
draw_set_color(c_white);