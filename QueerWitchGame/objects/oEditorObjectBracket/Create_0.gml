/// @description Editor Object Sub-Menu Init
// This is the sub menu that contains all the objects to select when using the editor

// Settings
expanded = false; // Checks if the Bracket is Open
selected = -1; // The index of what object has been selected (-1 for none)

// Check Length of Entity Type Options
var editor_data_length = 0;
for (var i = 0; i < global.editor_data_categories_length; i++) {
	if (global.editor_data[i + (entity_type * global.editor_data_categories_length), 0] != noone) {
		editor_data_length++;
	}
	else {
		break;
	}
}

// Object Options
options = noone;
for (var i = 0; i < editor_data_length; i++) {
	var temp_x_pos = i mod 3;
	var temp_y_pos = floor(i / 3);
	options[i] = instance_create_layer(x + 18 + (temp_x_pos * 36), y + 18 + (temp_y_pos * 36), layer, oEditorObjectSelect);
	options[i].button_image = global.editor_data[i + (entity_type * global.editor_data_categories_length), 1];
	options[i].button_name = object_get_name(global.editor_data[i + (entity_type * global.editor_data_categories_length), 0]);
	options[i].visible = false;
}

// Variables
height = ceil(i / 3) * 36;

hover_text = noone;
hover_text_details = noone;
hover_text_details_timer = 60;