/// weaponData();
/// @description Establishes the global variables for all weapon item data

/// ***Enums***
enum weaponstats {
	action_title,
	image_index,
	object,
	type,
	ammo
}

enum weapontype {
	melee,
	firearm
}

/// ***Weapons***

// Baseball Bat
global.weapon_data[0, weaponstats.action_title] = "Use Baseball Bat";
global.weapon_data[0, weaponstats.image_index] = 4;
global.weapon_data[0, weaponstats.object] = 2;
global.weapon_data[0, weaponstats.type] = weapontype.melee;
global.weapon_data[0, weaponstats.ammo] = -1;

// Baseball Bat
global.weapon_data[1, weaponstats.action_title] = "Marinda .308";
global.weapon_data[1, weaponstats.image_index] = 5;
global.weapon_data[1, weaponstats.object] = 2;
global.weapon_data[1, weaponstats.type] = weapontype.firearm;
global.weapon_data[1, weaponstats.ammo] = -1;