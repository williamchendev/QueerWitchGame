/// @description Unit Initialization Event
// Creates all the variables necessary for the Unit character

// Physics Settings
spd = 3; // Running Speed

jump_spd = 1.4; // Jumping Speed
double_jump_spd = 3; // Double Jumping Seed
hold_jump_spd = 0.45; // Added Jump Speed when the Jump Button is held
jump_decay = 0.81; // Decay of the Jumping Upwards Velocity

grav_spd = 0.026; // Force of Downward Gravity
grav_multiplier = 0.93; // Dampening Multiplyer of the Downward Velocity (Makes gravity smoother)
max_grav_spd = 2; // Max Speed of Unit's Downward Velocity

slope_tolerance = 3; // Tolerance for walking up slopes in pixels
//slope_angle_lerp_spd = 0.1; // Speed to lerp the angle to the slope the player is standing on

// Beahviour Settings
canmove = true;
player_input = true;

weapon_hip_x = -1;
weapon_hip_y = -24;

weapon_aim_x = 4;
weapon_aim_y = -32;

// Animation Settings
idle_animation = sCathIdle;
walk_animation = sCathRun;
jump_animation = sCathJump;

/*
idle_animation = sWillIdle;
walk_animation = sWillWalk;
jump_animation = sWillIdle;
*/

animation_spd = 0.18;

arm_x[0] = 2;
arm_y[0] = -32;

arm_x[1] = -5;
arm_y[1] = -32;

squash_stretch = 0.4;
scale_reset_spd = 0.15;

// Physics Variables
platform_list = ds_list_create();

x_velocity = 0;
y_velocity = 0;

double_jump = false;

grav_velocity = 0;
jump_velocity = 0;

slope_angle = 0;
slope_offset = 0;

backarm_layer_id = layer_create(((instance_number(oUnit) + 1) * -5) - 1, object_get_name(self) + "_" + string(instance_number(oUnit)) + "_backarmlayer");
layer_id = layer_create(((instance_number(oUnit) + 1) * -5) - 2, object_get_name(self) + "_" + string(instance_number(oUnit)) + "_layer");
weapon_layer_id = layer_create(((instance_number(oUnit) + 1) * -5) - 3, object_get_name(self) + "_" + string(instance_number(oUnit)) + "_weaponlayer");
frontarm_layer_id = layer_create(((instance_number(oUnit) + 1) * -5) - 4, object_get_name(self) + "_" + string(instance_number(oUnit)) + "_frontarmlayer");

layer = layer_id;

universal_physics_object = instance_create_layer(x, y, layer_id, oPhysics);
universal_physics_object.base_object = self;

// Behaviour Variables
weapons[0] = instance_create_layer(x, y, weapon_layer_id, oGun_M14);
weapons[0].equip = true;

target = noone;

weapon_x = 0;
weapon_y = 0;

aim_ambient_x = 0;
aim_ambient_y = 0;

// Animation Variables
draw_index = 0;

draw_xscale = 1;
draw_yscale = 1;

arms[0] = instance_create_layer(x, y, backarm_layer_id, oArm);
arms[1] = instance_create_layer(x, y, frontarm_layer_id, oArm);

image_speed = 0;

// Singleton
game_manager = instance_find(oGameManager, 0);