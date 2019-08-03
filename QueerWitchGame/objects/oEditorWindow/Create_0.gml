/// @description Editor Block Window Init
// An editor window that controls and organizes the placement of elements within it
// Ititalizaes variables necessary for the Editor Block Window Object

// Settings
window_title = "Debug";

width = 160;
height = 80;

title_height = 14;

camera_x_offset = 100;
camera_y_offset = 100;

// Variables
drag = false;

mouse_x_offset = 0;
mouse_y_offset = 0;

destroy = false;
destroyed = false;

// Elements
elements = noone;
element_offset = noone;

// Set Layer
window_depth = -6000;
var i = 1;
while (true) {
	var temp_check_layer = layer_get_id_at_depth(-6000 - (i * 10));
	if (temp_check_layer[0] == -1) {
		layer = layer_create(-6000 - (i * 10), "Editor_Window_" + string(i));
		window_depth = -6000 - (i * 10);
		break;
	}
	i++;
}

// Debug
sprite_index = noone;