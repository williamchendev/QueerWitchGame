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

platform_list = ds_list_create();

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

// Unit Stat Settings
ui_stat_x_offset = 0;
ui_stat_y_offset = 0;

name = "Debug Unit";
max_health_points = 3;
max_calories = 2000;

// Unit Stats Variables
draw_stats_mode = noone;
draw_stats_alpha = 0;

health_points = max_health_points;
health_points = 1;

calories = max_calories;
calories = 1000;

calorie_show = calories;
calorie_color_1 = make_color_rgb(17, 148, 255);
calorie_color_2 = make_color_rgb(29, 170, 255);
calorie_color_3 = make_color_rgb(41, 182, 255);
calorie_color_4 = make_color_rgb(0, 118, 225);

// GUI & Menu Settings
menu_lerp_spd = 0.1;

//select_menu_radius = 32;
select_menu_x_offset = 4;
select_menu_y_offset = -26;

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

select_alpha = 0;
select_menu_select = 0;
select_menu_draw_pos = 0;
select_option_lerp = 0;

select_update_option = false;
select_item_stacks = 0;
select_consumable_strength = 0;
select_can_use = false;

select_list = noone;
select_list_length = 0;

// Animation Settings
draw_sin_spd = 0.0074;
//squash_stretch = 0.2;
squash_stretch = 0.3;

idle_anim = sCathIdle;
walk_anim = sCathRun;
jump_anim = sCathJump;

// Animation Variables
sin_val = random_range(0.0, 1.0);

draw_xscale = 1;
draw_yscale = 1;

// Singleton
game_manager = instance_find(oGameManager, 0);