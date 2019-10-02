/// @description Enemy Initialization Event
// Creates variables necessary for the enemy character

// Movement Settings
grav = 0.025;
grav_multiplier = 0.92;
max_grav = 1.5;

spd = 0.5;

jump_spd = 3;

slope_lerp_spd = 0.1;
slope_tolerance = 3;

// Movement Variables
grav_velocity = 0;
jump_velocity = 0;
x_velocity = 0;
y_velocity = 0;

slope_angle = 0;
slope_offset = 0;

platform_list = ds_list_create();

// Behaviour Variables
enum enemybehaviour {
	inert,
	guard,
	patrol,
	npc,
	cutscene
}

combat_mode = false;
behaviour_state = enemybehaviour.patrol;

universal_physics_object = instance_create_layer(x, y, layer, oPhysics);
universal_physics_object.base_object = self;

// Pathfinding Variables
enum pathfinding {
	basic,
	astar
}
pathfinding_active = false;
pathfinding_type = pathfinding.basic;

target_x = x;
target_y = y;

// Animation Settings
squash_stretch = 0.2;

idle_anim = sWillIdle;
jump_anim = sWillIdle;
walk_anim = sWillWalk;

// Animation Variables
draw_xscale = 1;
draw_yscale = 1;

//**DEBUG**
hp = 4;