/// tilesetClear(tileset);
/// @description Clears all tiles placed on the given tileset and resets everything to empty
/// @param {real} tileset The id of the tileset object to clear

// Establish Variables
var temp_tileset = argument0;

// Clear the tileset
for (var h = 0; h < temp_tileset.height; h++) {
	for (var w = 0; w < temp_tileset.width; w++) {
		if (temp_tileset.tile_index[w, h] != -1) {
			temp_tileset.tile_index[w, h] = -1;
			layer_sprite_destroy(temp_tileset.tile_id[w, h]);
			temp_tileset.tile_id[w, h] = noone;
		}
	}
}