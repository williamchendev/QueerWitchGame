/// @description TileSet Sub-Menu Init
// This is the sub menu that contains all the tiles to select when using the editor

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

// Index the Tilesets
tilesets = noone;
for (var k = 0; k < editor_data_length; k++) {
	tilesets[k] = global.editor_data[k + (entity_type * global.editor_data_categories_length), 0];
}


// Create Air
options = noone;

options[0] = instance_create_layer(x + 18, y + 18, layer, oEditorObjectSelect);
options[0].button_image = sDebugEmpty;
options[0].button_index = 0;
options[0].button_name = "Air [Empty]";
options[0].visible = false;

// Create Tileset Options
for (var i = 1; i < sprite_get_number(tilesets[0]) + 1; i++) {
	var temp_x_pos = (i) mod 3;
	var temp_y_pos = floor(i / 3);
	options[i] = instance_create_layer(x + 18 + (temp_x_pos * 36), y + 18 + (temp_y_pos * 36), layer, oEditorObjectSelect);
	options[i].button_image = tilesets[oEditor.block_tileset_index];
	options[i].button_index = i - 1;
	options[i].button_name = sprite_get_name(tilesets[oEditor.block_tileset_index]) + "[" + string(i - 1) + "]";
	options[i].visible = false;
}

// Variables
height = ceil(i / 3) * 36;

hover_text = noone;
hover_text_details = noone;
hover_text_details_timer = 0;