/// @description Unit Initialization Event
// creates all the variables necessary for the Unit character

// Movement Settings
grav = 0.025;
grav_multiplier = 0.92;
max_grav = 1.5;

spd = 3;

jump_spd = 1.5;
jump_double_spd = 3;
jump_hold_spd = 0.4;
jump_decay = 0.8;

slope_lerp_spd = 0.1;
slope_tolerance = 3;

// Movement Variables
double_jump = false;

grav_velocity = 0;
jump_velocity = 0;
x_velocity = 0;
y_velocity = 0;

slope_angle = 0;

// Behaviour Variables
player_input = true;
canmove = true;

camera_follow = true;	
camera_follow_spd = 0.05;
camera_y_offset = -42;

universal_physics_object = instance_create_layer(x, y, layer, oPhysics);
universal_physics_object.base_object = self;

// Inventory Variables


// Animation Settings
squash_stretch = 0.2;

idle_anim = sCathIdle;
walk_anim = sCathRun;
jump_anim = sCathJump;

// Animation Variables
draw_xscale = 1;
draw_yscale = 1;