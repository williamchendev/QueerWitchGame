/// @description Weapon Initialization
// Creates the settings and variables of the wepaon object

// Instance Settings
game_manager = instance_find(oGameManager, 0);

// Weapon Settings
weapon_sprite = sMarinda308;

weapon_rotation = 0;
weapon_xscale = 1;
weapon_yscale = 1;

// Behaviour Settings
attack = false;
equip = false;
aiming = true;

// Behaviour Variables
aim = 0;