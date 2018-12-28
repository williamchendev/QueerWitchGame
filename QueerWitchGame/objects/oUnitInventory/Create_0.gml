/// @description Inventory Initialization

// Settings

// Object Mode Variables
object_mode = false;

// Inventory Variables
inventory = noone;
inventory_width = 0;
inventory_height = 0;

// Inventory GUI Mode Settings
inventory_grid_size = 16;
inventory_grid_space_size = 2;
inventory_offset_size = 4;
draw_offset_x = 24;
draw_offset_y = -56;

draw_lerp_spd = 0.1;
radial_spd = 0.0067;

// Inventory GUI Mode Variables
draw_inventory = false;
draw_inventory_open = false;

select_index = 0;
select_target_width = 1;
select_target_height = 1;

select_xpos = 0;
select_ypos = 0;
select_width = 0;
select_height = 0;

draw_alpha = 0;
sin_val = 0;
draw_inventory_outline_size = 0;
draw_inventory_x = x;
draw_inventory_y = y;

draw_sprite_index = noone;

// Singleton
game_manager = instance_find(oGameManager, 0);