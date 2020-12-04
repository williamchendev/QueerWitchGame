/// @description Insert description here
// You can write your code in this editor

// Data Structures Garbage Collection
ds_list_destroy(material_damage_sprite_index);
ds_list_destroy(material_damage_image_index);
ds_list_destroy(material_damage_x);
ds_list_destroy(material_damage_y);
ds_list_destroy(material_damage_x_scale);
ds_list_destroy(material_damage_y_scale);
ds_list_destroy(material_damage_angle);

material_damage_sprite_index = -1;
material_damage_image_index = -1;
material_damage_x = -1;
material_damage_y = -1;
material_damage_x_scale = -1;
material_damage_y_scale = -1;
material_damage_angle = -1;

ds_list_destroy(material_units);

material_units = -1;

// Clean Up Buffers
if (material_buffer != noone) {
	buffer_delete(material_buffer);
	material_buffer = -1;
}

// Clear Surfaces
surface_free(material_dmg_surface);
surface_free(material_surface);

material_dmg_surface = -1;
material_surface = -1;