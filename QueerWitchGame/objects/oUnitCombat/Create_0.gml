/// @description Combat Unit Initialization
// The variable and settings initialization for the Combat Unit

// Inherit Unit Initialization
event_inherited();

// Combat Variables
target = noone;

target_manual = false;
target_x = 0;
target_y = 0;

// Weapon Settings
weapon_hip_x = -1;
weapon_hip_y = -24;

weapon_aim_x = 4;
weapon_aim_y = -32;

// Limb Settings
limbs = 2;

limb_x[0] = 2;
limb_y[0] = -32;

limb_x[1] = -5;
limb_y[1] = -32;

limb_aim_move_offset_x = -1;
limb_aim_offset_y = 2;

// Knockout Settings
knockout = false;
knockout_active = false;
knockout_timer = 0.4;

// Weapon Variables
weapon_x = 0;
weapon_y = 0;

aim_ambient_x = 0;
aim_ambient_y = 0;

// Limb Variables
limb[0] = instance_create_layer(x, y, layers[1], oArm);
limb[1] = instance_create_layer(x, y, layers[4], oArm);

limb_sprite[0] = sWilliamDS_Arms;
limb_sprite[1] = sWilliam_Arms;