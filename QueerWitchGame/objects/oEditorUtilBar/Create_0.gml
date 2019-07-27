/// @description Editor Utility Bar Init Event
// Creates all the variables and settings for the Editor Utility Bar

// Settings
util_type = 0;
spacing = 30;

// Variables
start_spacing = 0;

buttons = noone;
for (var i = 0; i < 4; i++) {
	buttons[i] = instance_create_layer(x, y + (start_spacing * i), layer, oEditorButton);
	buttons[i].button_index = i;
}