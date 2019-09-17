/// @description New Block Window Init
// Creates the settings for the New Block File Window

// Inherit the parent event
event_inherited();

// Block File Settings
min_block_width = 4;
max_block_width = 80;
min_block_height = 7;
max_block_height = 400;

// Settings
window_title = "New Block File";

width = 160;
height = 80;

camera_x_offset = (oGameManager.camera_width / 2) - (width / 2);
camera_y_offset = (oGameManager.camera_height / 2) - (height / 2);
x = oGameManager.camera_x + camera_x_offset;
y = oGameManager.camera_y + camera_y_offset;

// Block Width
elements[0] = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorTextInput);
elements[0].text_input = 14; // Debug
elements[0].empty_text = "width";
elements[0].use_alpha = false;
elements[0].width = 60;
elements[0].text_limit = 5;

element_offset[0, 0] = 10;
element_offset[0, 1] = 24;

// Block Height
elements[1] = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorTextInput);
elements[1].text_input = 8; // Debug
elements[1].empty_text = "height";
elements[1].use_alpha = false;
elements[1].width = 60;
elements[1].text_limit = 5;

element_offset[1, 0] = 90;
element_offset[1, 1] = 24;

// Block Height
elements[2] = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorTextInput);
elements[2].text_input = "debug"; // Debug
elements[2].empty_text = "file name";
elements[2].use_alpha = true;
elements[2].width = 118;

element_offset[2, 0] = 10;
element_offset[2, 1] = 44;

// New File Button
elements[3] = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorButtonInput);
elements[3].button_name = "New File";
elements[3].width = 54;

element_offset[3, 0] = (width / 2) - (elements[3].width / 2);
element_offset[3, 1] = 66;