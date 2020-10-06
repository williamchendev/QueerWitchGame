/// material_add_damage(material,x,y);
/// @description Indexes damage done to a material
/// @param {real} material The Material Object to apply damage to
/// @param {real} x The x position of the damage
/// @param {real} y The y position of the damage
/// @returns {bool} True if the bullet touched an active pixel on the material

// Establish Variables
var temp_material = argument0;
var temp_x = argument1;
var temp_y = argument2;

// Check if Surface Exists
if (surface_exists(temp_material.material_surface)) {
	var temp_mat_x = clamp((temp_x - temp_material.x) + sprite_get_xoffset(temp_material.material_sprite), 0, sprite_get_width(temp_material.material_sprite));
	var temp_mat_y = clamp((temp_y - temp_material.y) + sprite_get_yoffset(temp_material.material_sprite), 0, sprite_get_height(temp_material.material_sprite));
	var temp_mat_dmg_color = surface_getpixel(temp_material.material_dmg_surface, temp_mat_x, temp_mat_y);
	var temp_mat_color = surface_getpixel(temp_material.material_surface, temp_mat_x, temp_mat_y);
	
	if (temp_mat_color != c_black) {
		if (temp_mat_dmg_color != c_white) {
			return true;
		}
	}
}
return false;