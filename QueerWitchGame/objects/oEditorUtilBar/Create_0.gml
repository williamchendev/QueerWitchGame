/// @description Editor Utility Bar Init Event
// Creates all the variables and settings for the Editor Utility Bar

// Settings
util_type = 0; // selected utility id
spacing = 30; // Space Between Options

// Variables
start_spacing = 0; // Controls the menu moving out on init

// Init Button objects
buttons = noone;
for (var i = 0; i < 6; i++) {
	buttons[i] = instance_create_layer(x, y + (start_spacing * i), layer, oEditorButton);
	buttons[i].button_index = i;
}