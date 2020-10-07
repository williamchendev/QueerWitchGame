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
if (temp_material.material_buffer != noone) {
	// Find Horizontal Position to Check
	var temp_x_check;
	if (sign(temp_material.image_xscale) >= 0) {
		temp_x_check = (temp_x - temp_material.x) + sprite_get_xoffset(temp_material.material_sprite)
	}
	else {
		temp_x_check = (sprite_get_width(temp_material.material_sprite) - sprite_get_xoffset(temp_material.material_sprite)) + (temp_x - temp_material.x);
	}
	
	// Find Buffer Variables
	var temp_mat_x = round(clamp(temp_x_check, 0, sprite_get_width(temp_material.material_sprite) - 1));
	var temp_mat_y = round(clamp((temp_y - temp_material.y) + sprite_get_yoffset(temp_material.material_sprite), 0, sprite_get_height(temp_material.material_sprite) - 1));
	var temp_mat_dmg_color = buffer_peek(temp_material.material_buffer, 4 * (temp_mat_x + (temp_mat_y * sprite_get_width(temp_material.material_sprite))), buffer_u32);
	var temp_mat_dmg_alpha = (temp_mat_dmg_color >> 24) & $ff;
	
	// Check for Collision
	if (temp_mat_dmg_alpha == 0) {
		return true;
	}
}
return false;