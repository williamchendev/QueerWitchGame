/// @description Surface Manager Init
// Initializes the Surface Manager

// Game Manager Singleton
game_manager = instance_find(oGameManager, 0);

// Manager Settings
calc_unit_overlay = false;
calc_interact_overlay = true;
units_outline = ds_map_create();
interacts_outline = ds_map_create();

// Camera Settings
camera_offset_width = 10;
camera_offset_height = 10;

// Surface Settings
unit_outline_surface = noone;
unit_outline_overlay_surface = noone;

interact_outline_surface = noone;

// Shader Settings
outline_texel_width = noone;
outline_texel_height = noone;
uniform_pixel_width = shader_get_uniform(shd_outline, "pixelW");
uniform_pixel_height = shader_get_uniform(shd_outline, "pixelH");

// Variables
draw_x = 0;
draw_y = 0;

// Debug
sprite_index = -1;