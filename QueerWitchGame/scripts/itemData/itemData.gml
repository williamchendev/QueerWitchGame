/// itemData();
/// @description Establishes the global variables for all item data

/// ***Enums***
enum itemstats
{
	name,
	description,
	sprite_index,
	image_index,
	width_space,
	height_space,
	stack_limit,
	type,
	type_index
}

/// ***Items***

// Null
global.item_data[0, itemstats.name] = "Empty";
global.item_data[0, itemstats.description] = "Empty";
global.item_data[0, itemstats.sprite_index] = sItems1x1;
global.item_data[0, itemstats.image_index] = 0;
global.item_data[0, itemstats.width_space] = 1;
global.item_data[0, itemstats.height_space] = 1;
global.item_data[0, itemstats.stack_limit] = 0;
global.item_data[0, itemstats.type] = "Empty";
global.item_data[0, itemstats.type_index] = 0;

// Debug
global.item_data[1, itemstats.name] = "Debug";
global.item_data[1, itemstats.description] = "This is a test of the system";
global.item_data[1, itemstats.sprite_index] = sItems1x1;
global.item_data[1, itemstats.image_index] = 0;
global.item_data[1, itemstats.width_space] = 1;
global.item_data[1, itemstats.height_space] = 1;
global.item_data[1, itemstats.stack_limit] = 1;
global.item_data[1, itemstats.type] = "Food";
global.item_data[1, itemstats.type_index] = 0;

// Granola Bar
global.item_data[2, itemstats.name] = "Granola Bar";
global.item_data[2, itemstats.description] = "It tastes gross but they're light and filling";
global.item_data[2, itemstats.sprite_index] = sItems1x1;
global.item_data[2, itemstats.image_index] = 1;
global.item_data[2, itemstats.width_space] = 1;
global.item_data[2, itemstats.height_space] = 1;
global.item_data[2, itemstats.stack_limit] = 4;
global.item_data[2, itemstats.type] = "Food";
global.item_data[2, itemstats.type_index] = 0;

// Trail Mix
global.item_data[3, itemstats.name] = "Trail Mix";
global.item_data[3, itemstats.description] = "An unfortunate blend of tasty chocolate and... raisins";
global.item_data[3, itemstats.sprite_index] = sItems2x2;
global.item_data[3, itemstats.image_index] = 0;
global.item_data[3, itemstats.width_space] = 2;
global.item_data[3, itemstats.height_space] = 2;
global.item_data[3, itemstats.stack_limit] = 1;
global.item_data[3, itemstats.type] = "Food";
global.item_data[3, itemstats.type_index] = 0;