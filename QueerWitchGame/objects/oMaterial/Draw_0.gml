/// @description Insert description here
// You can write your code in this editor

// Create Surface
if (!surface_exists(material_dmg_surface)) {
	material_dmg_surface = surface_create(sprite_get_width(material_sprite), sprite_get_height(material_sprite));
}
if (!surface_exists(material_surface)) {
	material_surface = surface_create(sprite_get_width(material_sprite), sprite_get_height(material_sprite));
}

// Reset Material Damage Surface
surface_set_target(material_dmg_surface);
draw_clear_alpha(c_black,0);

// Index Damage to Material Damage Surface
if (material_damage > 0) {
	for (var i = 0; i < material_damage; i++) {
		// Material Damage Variables
		var temp_dmg_sprite = ds_list_find_value(material_damage_sprite_index, i);
		var temp_dmg_image = ds_list_find_value(material_damage_image_index, i);
		var temp_dmg_x = ds_list_find_value(material_damage_x, i) + sprite_get_xoffset(material_sprite);
		var temp_dmg_y = ds_list_find_value(material_damage_y, i) + sprite_get_yoffset(material_sprite);
		var temp_dmg_x_scale = ds_list_find_value(material_damage_x_scale, i);
		var temp_dmg_y_scale = ds_list_find_value(material_damage_y_scale, i);
		var temp_dmg_angle = ds_list_find_value(material_damage_angle, i);
		
		draw_sprite_ext(temp_dmg_sprite, temp_dmg_image, temp_dmg_x, temp_dmg_y, temp_dmg_x_scale, temp_dmg_y_scale, temp_dmg_angle, c_white, 1);
	}
}

// Reset Surface Target
surface_reset_target();

// Instantiate New Surface
surface_set_target(material_surface);
draw_clear_alpha(c_black,0);
draw_sprite(material_sprite, 0, sprite_get_xoffset(material_sprite), sprite_get_yoffset(material_sprite));
surface_reset_target();

// Draw Surface
shader_set(shd_subtract_alpha);
texture_set_stage(material_alpha_tex, surface_get_texture(material_dmg_surface));
draw_surface(material_surface, x + sprite_get_xoffset(material_sprite), y + sprite_get_yoffset(material_sprite));
shader_reset();