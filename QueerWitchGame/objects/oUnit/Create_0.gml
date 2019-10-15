/// @description Unit Initialization Event
// Creates all the variables necessary for the Unit character

// Physics Settings
spd = 3; // Running Speed

jump_spd = 1.5; // Jumping Speed
double_jump_spd = 3; // Double Jumping Seed
hold_jump_spd = 0.4; // Added Jump Speed when the Jump Button is held
jump_decay = 0.8;

grav_spd = 0.025; // Force of Downward Gravity
grav_multiplier = 0.92;
max_grav_spd = 1.5; // Max Speed of Unit's Downward Velocity

slope_tolerance = 3; // Tolerance for walking up slopes in pixels
slope_angle_lerp_spd = 0.1; // Speed to lerp the angle to the slope the player is standing on

// Physics Variables
platform_list = ds_list_create();

canmove = true;
player_input = true;
double_jump = false;

x_velocity = 0;
y_velocity = 0;

grav_velocity = 0;
jump_velocity = 0;

slope_angle = 0;
slope_offset = 0;

universal_physics_object = instance_create_layer(x, y, layer, oPhysics);
universal_physics_object.base_object = self;

// Singleton
game_manager = instance_find(oGameManager, 0);