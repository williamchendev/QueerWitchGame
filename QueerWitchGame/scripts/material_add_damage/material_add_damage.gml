/// material_add_damage(material,sprite_index,image_index,x,y,x_scale,y_scale,angle);
/// @description Indexes damage done to a material
/// @param {real} material The Material Object to apply damage to
/// @param {real} sprite_index The Sprite Index of the Damage map
/// @param {real} image_index The Image Index of the Damage map
/// @param {real} x The x position of the damage
/// @param {real} y The y position of the damage
/// @param {real} x_scale The x scale of the Damage map
/// @param {real} y_scale The y scale of the Damage map
/// @param {real} angle The direction/angle of the raycast to check

// Establish Variables
var temp_material = argument0;
var temp_sprite_index = argument1;
var temp_image_index = argument2;
var temp_x = argument3;
var temp_y = argument4;
var temp_x_scale = argument5;
var temp_y_scale = argument6;
var temp_angle = argument7;

// Index Damage
temp_material.material_damage++;
ds_list_add(temp_material.material_damage_sprite_index, temp_sprite_index);
ds_list_add(temp_material.material_damage_image_index, temp_image_index);
ds_list_add(temp_material.material_damage_x, (temp_x - temp_material.x) * temp_material.image_xscale);
ds_list_add(temp_material.material_damage_y, temp_y - temp_material.y);
ds_list_add(temp_material.material_damage_x_scale, temp_x_scale);
ds_list_add(temp_material.material_damage_y_scale, temp_y_scale);
ds_list_add(temp_material.material_damage_angle, temp_angle);