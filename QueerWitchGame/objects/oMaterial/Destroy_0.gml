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

ds_list_destroy(material_units);

// Clean Up Buffers
if (material_buffer != noone) {
	buffer_delete(material_buffer);
}

// Clear Surfaces
surface_free(material_dmg_surface);
surface_free(material_surface);