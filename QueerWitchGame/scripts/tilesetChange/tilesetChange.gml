/// tilesetChange(tileset,sprite_index);
/// @description Changes the sprite index of the provided tileset object
/// @param {real} tileset The id of the tileset object to change the sprite index of
/// @param {real} sprite_index The new sprite_index of the tileset

// Establish Variables
var temp_tileset = argument0;
var temp_spriteindex = argument1;

var max_index = sprite_get_number(temp_spriteindex);

// Set new tileset
temp_tileset.tileset = temp_spriteindex;

for (var h = 0; h < temp_tileset.height; h++) {
	for (var w = 0; w < temp_tileset.width; w++) {
		if (temp_tileset.tile_index[w, h] != -1) {
			if (temp_tileset.tile_index[w, h] >= max_index) {
				temp_tileset.tile_index[w, h] = -1;
				layer_sprite_destroy(temp_tileset.tile_id[w, h]);
				temp_tileset.tile_id[w, h] = noone;
			}
			else {
				layer_sprite_change(temp_tileset.tile_id[w, h], temp_spriteindex);
			}
		}
	}
}

// Reset Editor Tiles
if (instance_exists(oEditor)) {
	if (oEditor.editor_mode == editortypes.block) {
		with (oEditorTileSetBracket) {
			for (var i = 0; i < array_length_1d(options); i++) {
				instance_destroy(options[i]);
			}
			
			options = noone;
			for (var i = 0; i < sprite_get_number(tilesets[0]); i++) {
				var temp_x_pos = i mod 3;
				var temp_y_pos = floor(i / 3);
				options[i] = instance_create_layer(x + 18 + (temp_x_pos * 36), y + 18 + (temp_y_pos * 36), layer, oEditorObjectSelect);
				options[i].button_image = tilesets[oEditor.block_tileset_index];
				options[i].button_index = i;
				options[i].button_name = sprite_get_name(tilesets[oEditor.block_tileset_index]) + "[" + string(i) + "]";
				options[i].visible = false;
			}
		}
		
		if (oEditorObjectSelectMenu.selected_menu == 1) {
			oEditorObjectSelectMenu.selected_menu = -1;
			oEditorObjectSelectMenu.selected_index = -1;
		}
	}
}