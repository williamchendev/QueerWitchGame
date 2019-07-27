/// @description Insert description here
// You can write your code in this editor

// Settings
expanded = false;
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
height = ceil(i / 3);
hover_text = noone;