/// @description Corn Population Initialization
// creates the corn population in an enviroment

// Get positional variables
width = sprite_width;
far_left_x = x - (sprite_width / 2);

// Create Corn Population
for (i = 0; i < sprite_width; i += corn_density) {
	var temp_x = clamp((far_left_x + i) + random_range(-20, 20), far_left_x, far_left_x + width);
	var corn_obj = instance_create_layer(temp_x, y, layer, oCorn);
	corn_obj.base_color_change = base_color_change;
}