/// tilesetColor(tileset,color,alpha);
/// @description Changes the color (and optionally the alpha) of the provided tileset object
/// @param {real} tileset The id of the tileset object to change the color/alpha of
/// @param {real} color The new color to blend with the given tileset
/// @param {real} alpha The new alpha to blend with the given tileset

// Establish Variables
var temp_tileset = argument[0];
var temp_color = argument[1];
temp_tileset.color = temp_color;

var temp_alpha = temp_tileset.alpha;
if (argument_count > 2) {
	temp_alpha = argument[2];
	temp_tileset.alpha = temp_alpha;
}

// Set the new properties to the tileset
for (var h = 0; h < temp_tileset.height; h++) {
	for (var w = 0; w < temp_tileset.width; w++) {
		if (temp_tileset.tile_index[w, h] != -1) {
			layer_sprite_blend(temp_tileset.tile_id[w, h], temp_color);
			layer_sprite_alpha(temp_tileset.tile_id[w, h], temp_alpha);
		}
	}
}