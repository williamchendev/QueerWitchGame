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