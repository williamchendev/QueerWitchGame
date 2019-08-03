/// tilesetSet(tileset,x,y,index);
/// @description Edits the tileset by setting a tile at the given coordinate within the tileset array
/// @param {real} tileset The tileset object id to set a tile in
/// @param {integer} x The X coordinate in the tileset object's array to set the tile
/// @param {integer} y The Y coordinate in the tileset object's array to set the tile
/// @param {integer} index The given index of the desired tile being set in the array

// Establish Variables
var temp_tileset = argument0;
var temp_x = argument1;
var temp_y = argument2;
var temp_index = argument3;

// Check if tile is within bounds
if (temp_x < 0 and temp_x >= temp_tileset.width) {
	return;
}
if (temp_y < 0 and temp_y >= temp_tileset.height) {
	return;
}

// Get Tileset Properties
var temp_color = temp_tileset.color;
var temp_alpha = temp_tileset.alpha;
var temp_layer = temp_tileset.tile_layer;
var temp_sprite = temp_tileset.tileset;

var temp_tile_x = temp_tileset.x + (temp_x * 48);
var temp_tile_y = temp_tileset.y + (temp_y * 48);

// Set Tile
if (temp_tileset.tile_index[temp_x, temp_y] != temp_index) {
	if (temp_tileset.tile_index[temp_x, temp_y] != -1) {
		layer_sprite_destroy(temp_tileset.tile_id[temp_x, temp_y]);
		temp_tileset.tile_id[temp_x, temp_y] = noone;
	}
	temp_tileset.tile_index[temp_x, temp_y] = temp_index;
	temp_tileset.tile_id[temp_x, temp_y] = layer_sprite_create(temp_layer, temp_tile_x, temp_tile_y, temp_sprite);
	var temp_tile = temp_tileset.tile_id[temp_x, temp_y];
}
else {
	return;
}

// Set Tile properties
layer_sprite_speed(temp_tile, 0);
layer_sprite_blend(temp_tile, temp_color);
layer_sprite_alpha(temp_tile, temp_alpha);
layer_sprite_index(temp_tile, temp_index);