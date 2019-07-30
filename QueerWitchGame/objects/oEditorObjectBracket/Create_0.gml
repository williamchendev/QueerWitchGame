/// @description Editor Object Sub-Menu Init
// This is the sub menu that contains all the objects to select when using the editor

// Settings
expanded = false;
selected = -1;

// Object Options
options = noone;
for (var i = 0; i < array_length_2d(global.editor_entity_data, entity_type); i++) {
	var temp_x_pos = i mod 3;
	var temp_y_pos = floor(i / 3);
	options[i] = instance_create_layer(x + 18 + (temp_x_pos * 36), y + 18 + (temp_y_pos * 36), layer, oEditorObjectSelect);
	options[i].button_image = global.editor_icon_data[entity_type, i];
	options[i].button_name = object_get_name(global.editor_entity_data[entity_type, i]);
	options[i].visible = false;
}

// Variables
height = ceil(i / 3) * 36;
hover_text = noone;