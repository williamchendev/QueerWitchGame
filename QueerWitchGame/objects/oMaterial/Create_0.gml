/// @description Material Instantiation
// Instantiates the Settings for the Material

// Material Settings
material_sprite = sprite_index;

// Material Variables
material_damage = 0;
material_damage_sprite_index = ds_list_create();
material_damage_image_index = ds_list_create();
material_damage_x = ds_list_create();
material_damage_y = ds_list_create();
material_damage_x_scale = ds_list_create();
material_damage_y_scale = ds_list_create();
material_damage_angle = ds_list_create();

// Unit Variables
material_team_id = noone;
material_units = ds_list_create();

// Surface Variables
material_dmg_surface = noone;
material_surface = noone

// Buffer Variables
material_buffer = noone;

// Shader Textures
material_alpha_tex = shader_get_sampler_index(shd_subtract_alpha, "alphaTex");