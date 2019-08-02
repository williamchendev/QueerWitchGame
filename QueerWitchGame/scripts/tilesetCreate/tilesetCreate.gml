/// tilesetCreate(x,y,width,height,layer,sprite_index,color,alpha);
/// @description Creates a new tileset object with the given parameters
/// @param {integer} x The X coordinate of the new tileset object
/// @param {integer} y The Y coordinate of the new tileset object
/// @param {integer} width The width of the new tileset
/// @param {integer} height The height of the new tileset
/// @param {real} layer The id of the layer of the new tileset (sprite layer)
/// @param {real} sprite_index The id of the sprite index that the tileset will use
/// @param {real} color The color to blend the new tileset with (optional)
/// @param {real} alpha The alpha transparency to blend the new tileset with (optional)
/// @returns {real} The id of the new empty tileset object

// Establish Variables
var temp_x = argument[0]
var temp_y = argument[1]
var temp_width = argument[2];
var temp_height = argument[3];
var temp_layer = argument[4];
var temp_spriteindex = argument[5];

var temp_color = c_white;
if (argument_count > 6) {
	temp_color = argument[6];
}
var temp_alpha = 1;
if (argument_count > 7) {
	temp_alpha = argument[7];
}

// Create Tileset
var temp_tileset = instance_create_layer(temp_x, temp_y, layer_get_id("Instances"), oTileset);
temp_tileset.width = temp_width;
temp_tileset.height = temp_height;
temp_tileset.tile_layer = temp_layer;
temp_tileset.tileset = temp_spriteindex;
temp_tileset.color = temp_color;
temp_tileset.alpha = temp_alpha;

for (var h = 0; h < temp_height; h++) {
	for (var w = 0; w < temp_width; w++) {
		temp_tileset.tile_index[w, h] = -1;
		temp_tileset.tile_id[w, h] = noone;
	}
}

// Return Tileset Object
return temp_tileset;