/// weaponData();
/// @description Establishes the global variables for all weapon item data

/// ***Enums***
enum weaponstats {
	action_title,
	image_index,
	type,
	damage,
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
global.weapon_data[0, weaponstats.type] = weapontype.melee;
global.weapon_data[0, weaponstats.damage] = 2;
global.weapon_data[0, weaponstats.ammo] = -1;