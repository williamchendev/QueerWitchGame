/// @description TileSet Sub-Menu Init
// This is the sub menu that contains all the tiles to select when using the editor

// Settings
expanded = false;
selected = -1;

// Object Options
tilesets = noone;
for (var k = 0; k < array_length_2d(global.editor_entity_data, entity_type); k++) {
	tilesets[k] = global.editor_entity_data[entity_type, k];
}

options = noone;
for (var i = 0; i < sprite_get_number(tilesets[0]); i++) {
	var temp_x_pos = i mod 3;
	var temp_y_pos = floor(i / 3);
	options[i] = instance_create_layer(x + 18 + (temp_x_pos * 36), y + 18 + (temp_y_pos * 36), layer, oEditorObjectSelect);
	options[i].button_image = tilesets[0];
	options[i].button_index = i;
	options[i].button_name = sprite_get_name(tilesets[0]) + "[" + string(i) + "]";
	options[i].visible = false;
}

// Variables
height = ceil(i / 3) * 36;
hover_text = noone;