/// @description Unit Initialization Event
// Creates all the variables necessary for the Unit character

// Physics Settings
spd = 3; // Running Speed
walk_spd = 1; // Walk Speed

jump_spd = 1.4; // Jumping Speed
double_jump_spd = 3; // Double Jumping Seed
hold_jump_spd = 0.45; // Added Jump Speed when the Jump Button is held
jump_decay = 0.81; // Decay of the Jumping Upwards Velocity

grav_spd = 0.026; // Force of Downward Gravity
grav_multiplier = 0.93; // Dampening Multiplyer of the Downward Velocity (Makes gravity smoother)
max_grav_spd = 2; // Max Speed of Unit's Downward Velocity

slope_tolerance = 3; // Tolerance for walking up slopes in pixels
slope_angle_lerp_spd = 0.1; // Speed to lerp the angle to the slope the player is standing on

// Beahviour Settings
canmove = true;

team_id = "unassigned";

health_show = true;
health_points = 6;
max_health_points = 6;

// Animation Settings
idle_animation = sCathIdle;
walk_animation = sCathRun;
jump_animation = sCathJump;
aim_animation = sWilliamDS_Aim;
aim_walk_animation = sWilliamDS_Aim_Walk;
hurt_animation = sWilliam_Hurt;

/*
idle_animation = sWillIdle;
walk_animation = sWillWalk;
jump_animation = sWillIdle;
*/

animation_spd = 0.18;

squash_stretch = 0.4;
scale_reset_spd = 0.15;

// Ragdoll Settings
ragdoll = true;
ragdoll_head_sprite = sWilliamDS_Head;
ragdoll_arm_left_sprite = sWilliamDS_Arms;
ragdoll_arm_right_sprite = sWilliam_Arms;
ragdoll_chest_sprite = sWilliamDS_Chest;
ragdoll_leg_left_sprite = sWilliamDS_LeftLeg;
ragdoll_leg_right_sprite = sWilliamDS_RightLeg;

// Physics Variables
platform_list = ds_list_create();

x_velocity = 0;
y_velocity = 0;

double_jump = false;

grav_velocity = 0;
jump_velocity = 0;

slope_angle = 0;
slope_offset = 0;

universal_physics_object = instance_create_layer(x, y, layer_get_id("Instances"), oPhysics);
universal_physics_object.base_object = self;

// Animation Variables
draw_index = 0;

draw_color = c_white;
draw_alpha = 1;

draw_xscale = 1;
draw_yscale = 1;

draw_angle = 0;

jump_peak_threshold = 0.8;

image_speed = 0;

// Ragdoll Variables
force_applied = false;
force_x = 0;
force_y = 0;
force_xvector = 0;
force_yvector = 0;

arm_left_angle_1 = 0;
arm_left_angle_2 = 0;
arm_right_angle_1 = 0;
arm_right_angle_2 = 0;

// Input Variables
key_left = false;
key_right = false;
key_up = false;
key_down = false;

key_left_press = false;
key_right_press = false;
key_up_press = false;
key_down_press = false;

key_select_press = false;
key_cancel_press = false;
key_menu_press = false;

key_fire_press = false;
key_aim_press = false;

key_command = false;

// Inventory
inventory = createEmptyInventory(6, 4);

// Singleton
game_manager = instance_find(oGameManager, 0);
ds_list_add(game_manager.instantiated_units, self);

// Layers
layer_id = -1;

var temp_layer_id = 0;
var temp_unit_layers = ds_list_create();
for (var i = 0; i < instance_number(oUnit); i++) {
	var temp_unit = instance_find(oUnit, i);
	if (ds_list_find_index(game_manager.instantiated_units, temp_unit) != -1) {
		ds_list_add(temp_unit_layers, temp_unit.layer_id);
	}
}
ds_list_sort(temp_unit_layers, true);

for (var i = 0; i < ds_list_size(temp_unit_layers); i++) {
	var temp_unit_layer_id = ds_list_find_value(temp_unit_layers, i);
	if (temp_layer_id == temp_unit_layer_id) {
		temp_layer_id++;
	}
	else if (temp_layer_id < temp_unit_layer_id) {
		break;
	}
}
ds_list_destroy(temp_unit_layers);
layer_id = temp_layer_id;

for (var i = 0; i < 5; i++) {
	layers[i] = layer_create(((layer_id + 1) * -5) - i, object_get_name(self) + "_" + string(instance_number(oUnit)) + "_layer" + string(i));
}

layer = layers[2];