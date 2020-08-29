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

enum itemtypes
{
	consumable,
	weapon,
	ammo,
	key_item
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

// Debug Candy
global.item_data[1, itemstats.name] = "Debug Candy";
global.item_data[1, itemstats.description] = "It's a rare candy made to debug games.";
global.item_data[1, itemstats.sprite_index] = sItems1x1;
global.item_data[1, itemstats.image_index] = 0;
global.item_data[1, itemstats.width_space] = 1;
global.item_data[1, itemstats.height_space] = 1;
global.item_data[1, itemstats.stack_limit] = 1;
global.item_data[1, itemstats.type] = itemtypes.consumable;
global.item_data[1, itemstats.type_index] = 0;

// Granola Bar
global.item_data[2, itemstats.name] = "Granola Bar";
global.item_data[2, itemstats.description] = "It tastes gross but they're light and filling";
global.item_data[2, itemstats.sprite_index] = sItems1x1;
global.item_data[2, itemstats.image_index] = 1;
global.item_data[2, itemstats.width_space] = 1;
global.item_data[2, itemstats.height_space] = 1;
global.item_data[2, itemstats.stack_limit] = 4;
global.item_data[2, itemstats.type] = itemtypes.consumable;
global.item_data[2, itemstats.type_index] = 1;

// Trail Mix
global.item_data[3, itemstats.name] = "Trail Mix";
global.item_data[3, itemstats.description] = "An unfortunate blend of tasty chocolate and... raisins";
global.item_data[3, itemstats.sprite_index] = sItems2x2;
global.item_data[3, itemstats.image_index] = 0;
global.item_data[3, itemstats.width_space] = 2;
global.item_data[3, itemstats.height_space] = 2;
global.item_data[3, itemstats.stack_limit] = 1;
global.item_data[3, itemstats.type] = itemtypes.consumable;
global.item_data[3, itemstats.type_index] = 2;

// Baseball Bat
global.item_data[4, itemstats.name] = "Baseball Bat";
global.item_data[4, itemstats.description] = "Smmmmaaaaashhhhhhh!";
global.item_data[4, itemstats.sprite_index] = sItems4x1;
global.item_data[4, itemstats.image_index] = 1;
global.item_data[4, itemstats.width_space] = 4;
global.item_data[4, itemstats.height_space] = 1;
global.item_data[4, itemstats.stack_limit] = 1;
global.item_data[4, itemstats.type] = itemtypes.weapon;
global.item_data[4, itemstats.type_index] = 0;

// M14
global.item_data[5, itemstats.name] = "Marinda .308";
global.item_data[5, itemstats.description] = "Arkov's standard issue rifle, a traditon-bound old world firearm. The markings indicate it was manufactured in Rasa.";
global.item_data[5, itemstats.sprite_index] = sItems6x2;
global.item_data[5, itemstats.image_index] = 1;
global.item_data[5, itemstats.width_space] = 6;
global.item_data[5, itemstats.height_space] = 2;
global.item_data[5, itemstats.stack_limit] = 1;
global.item_data[5, itemstats.type] = itemtypes.weapon;
global.item_data[5, itemstats.type_index] = 1;

// FAL
global.item_data[6, itemstats.name] = "FAL-E";
global.item_data[6, itemstats.description] = "The right arm of the free world, now in burst fire";
global.item_data[6, itemstats.sprite_index] = sItems6x2;
global.item_data[6, itemstats.image_index] = 2;
global.item_data[6, itemstats.width_space] = 6;
global.item_data[6, itemstats.height_space] = 2;
global.item_data[6, itemstats.stack_limit] = 1;
global.item_data[6, itemstats.type] = itemtypes.weapon;
global.item_data[6, itemstats.type_index] = 2;

// 308 Winchester Ammo
global.item_data[7, itemstats.name] = ".308 Winchester Ammo";
global.item_data[7, itemstats.description] = "";
global.item_data[7, itemstats.sprite_index] = sItems1x1;
global.item_data[7, itemstats.image_index] = 2;
global.item_data[7, itemstats.width_space] = 1;
global.item_data[7, itemstats.height_space] = 1;
global.item_data[7, itemstats.stack_limit] = 2;
global.item_data[7, itemstats.type] = itemtypes.ammo;
global.item_data[7, itemstats.type_index] = 0;