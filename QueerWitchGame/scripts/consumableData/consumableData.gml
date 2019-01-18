/// consumableData();
/// @description Establishes the global variables for all consumable item data

/// ***Enums***
enum consumablestats {
	action_title,
	image_index,
	type,
	strength,
	status_effects,
	effect_strength,
	users_whitelist,
	users_blacklist
}

enum consumabletype {
	heal,
	calories,
	damage,
	defence,
	agility,
	luck
}

/// ***Consumables***

// Debug Candy
global.consumable_data[0, consumablestats.action_title] = "Eat Debug Candy";
global.consumable_data[0, consumablestats.image_index] = 1;
global.consumable_data[0, consumablestats.type] = consumabletype.heal;
global.consumable_data[0, consumablestats.strength] = 1;
global.consumable_data[0, consumablestats.status_effects] = noone;
global.consumable_data[0, consumablestats.effect_strength] = noone;
global.consumable_data[0, consumablestats.users_whitelist] = noone;
global.consumable_data[0, consumablestats.users_blacklist] = noone;

// Granola Bar
global.consumable_data[1, consumablestats.action_title] = "Eat Granola Bar";
global.consumable_data[1, consumablestats.image_index] = 2;
global.consumable_data[1, consumablestats.type] = consumabletype.calories;
global.consumable_data[1, consumablestats.strength] = 50;
global.consumable_data[1, consumablestats.status_effects] = noone;
global.consumable_data[1, consumablestats.effect_strength] = noone;
global.consumable_data[1, consumablestats.users_whitelist] = noone;
global.consumable_data[1, consumablestats.users_blacklist] = noone;

// Trail Mix
global.consumable_data[2, consumablestats.action_title] = "Eat Trail Mix";
global.consumable_data[2, consumablestats.image_index] = 2;
global.consumable_data[2, consumablestats.type] = consumabletype.calories;
global.consumable_data[2, consumablestats.strength] = 150;
global.consumable_data[2, consumablestats.status_effects] = noone;
global.consumable_data[2, consumablestats.effect_strength] = noone;
global.consumable_data[2, consumablestats.users_whitelist] = noone;
global.consumable_data[2, consumablestats.users_blacklist] = noone;