/// @description Play Demo Window Init
// Creates the settings for the Play Demo Window

// Inherit the parent event
event_inherited();

// Block File Settings
min_block_width = 4;
max_block_width = 80;
min_block_height = 7;
max_block_height = 400;

// Settings
window_title = "Demo File";

width = 160;
height = 60;

camera_x_offset = (oGameManager.camera_width / 2) - (width / 2);
camera_y_offset = (oGameManager.camera_height / 2) - (height / 2);
x = oGameManager.camera_x + camera_x_offset;
y = oGameManager.camera_y + camera_y_offset;

// File Path
elements[0] = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorTextInput);
elements[0].text_input = "debug"; // Debug
elements[0].empty_text = "file path";
elements[0].use_alpha = true;
elements[0].width = 140;

element_offset[0, 0] = 10;
element_offset[0, 1] = 24;

// New File Button
elements[1] = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorButtonInput);
elements[1].button_name = "Play";
elements[1].width = 54;

element_offset[1, 0] = (width / 2) - (elements[1].width / 2);
element_offset[1, 1] = 46;