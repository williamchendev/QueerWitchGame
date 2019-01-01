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
slope_offset = 0;

// Behaviour Variables
player_input = true;
canmove = true;
gui_mode = noone;

camera_follow = true;	
camera_follow_spd = 0.05;
camera_y_offset = -42;

universal_physics_object = instance_create_layer(x, y, layer, oPhysics);
universal_physics_object.base_object = self;

// Inventory Variables
unit_inventory = createEmptyInventory(6, 4);
debugInventoryPopulationFill1(unit_inventory);

// GUI & Menu Settings
menu_lerp_spd = 0.1;

// GUI & Menu Variables
menu_alpha = 0;

menu_radial_select = 0;
menu_radial_draw_pos = 0;
menu_radial_target_pos = 0;
for (var i = 0; i < 5; i++) {
	menu_radial_node[i, 0] = x;
	menu_radial_node[i, 1] = 1;
	menu_radial_node[i, 2] = 0;
}

// Animation Settings
draw_sin_spd = 0.0074;
squash_stretch = 0.2;

idle_anim = sCathIdle;
walk_anim = sCathRun;
jump_anim = sCathJump;

// Animation Variables
sin_val = random_range(0.0, 1.0);

draw_xscale = 1;
draw_yscale = 1;

// Singleton
game_manager = instance_find(oGameManager, 0);