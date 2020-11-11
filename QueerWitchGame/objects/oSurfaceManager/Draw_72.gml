/// @description Surface Manager Skip Draw
// Skips the Draw Event as to not draw itself to the screen

// Draw Interact Overlay
if (calc_interact_overlay) {
	// Check Surface Exists
	if (!surface_exists(interact_outline_surface)) {
		// Init new Surface
		interact_outline_surface = surface_create(game_manager.game_width + (camera_offset_width * 2), game_manager.game_height + (camera_offset_height * 2));
	}
	
	// Init Outline Shader Settings
	outline_texel_width = texture_get_texel_width(surface_get_texture(interact_outline_surface));
	outline_texel_height = texture_get_texel_height(surface_get_texture(interact_outline_surface));
	
	// Interate Through Selected Units
	var temp_interact_outline_index = ds_map_find_first(interacts_outline);
	var temp_interact_outline_map_size = ds_map_size(interacts_outline);
	for (var k = 0; k < temp_interact_outline_map_size; k++) {
		// Unit Variables
		var temp_interact_outline_color = ds_map_find_value(interacts_outline, temp_interact_outline_index);
		
		// Check Interact Object Surface Exists
		if (!surface_exists(temp_interact_outline_index.interact_surface)) {
			// Init new Surface
			temp_interact_outline_index.interact_surface = surface_create(game_manager.game_width + (camera_offset_width * 2), game_manager.game_height + (camera_offset_height * 2));
		}
		
		// Reset Overlay Surface
		surface_set_target(temp_interact_outline_index.interact_surface);
		draw_clear_alpha(c_black,0);
		surface_reset_target();
		
		// Reset Unit Select Surface Surface
		surface_set_target(interact_outline_surface);
		draw_clear_alpha(temp_interact_outline_color, 0);
	
		// Draw Instance
		with (temp_interact_outline_index.interact_obj) {
			// Set Position
			x = x - (other.game_manager.camera_x - other.camera_offset_width);
			y = y - (other.game_manager.camera_y - other.camera_offset_height);
					
			// Draw Object
			event_perform(ev_draw, 0);
					
			// Reset Position
			x = x + (other.game_manager.camera_x - other.camera_offset_width);
			y = y + (other.game_manager.camera_y - other.camera_offset_height);
		}
	
		// Reset Surface Target
		surface_reset_target();
	
		// Init Shader
		shader_set(shd_outline);

		shader_set_uniform_f(uniform_pixel_width, outline_texel_width);
		shader_set_uniform_f(uniform_pixel_height, outline_texel_height);
	
		// Draw Unit Select Surface to Overlay Surface
		surface_set_target(temp_interact_outline_index.interact_surface);
		draw_surface(interact_outline_surface, 0, 0);
		surface_reset_target();
	
		// Reset Shader
		shader_reset();
	}
	
	// Clear DS Map
	ds_map_clear(interacts_outline);
}

// Draw Unit Overlay
if (calc_unit_overlay) {
	// Check Surface Exists
	if (!surface_exists(unit_outline_surface)) {
		// Init new Surface
		unit_outline_surface = surface_create(game_manager.game_width + (camera_offset_width * 2), game_manager.game_height + (camera_offset_height * 2));
	}
	if (!surface_exists(unit_outline_overlay_surface)) {
		// Init new Surface
		unit_outline_overlay_surface = surface_create(game_manager.game_width + (camera_offset_width * 2), game_manager.game_height + (camera_offset_height * 2));
	}

	// Init Outline Shader Settings
	outline_texel_width = texture_get_texel_width(surface_get_texture(unit_outline_surface));
	outline_texel_height = texture_get_texel_height(surface_get_texture(unit_outline_surface));

	// Reset Overlay Surface
	surface_set_target(unit_outline_overlay_surface);
	draw_clear_alpha(c_black,0);
	surface_reset_target();

	// Interate Through Selected Units
	var temp_unit_outline_index = ds_map_find_first(units_outline);
	var temp_unit_outline_map_size = ds_map_size(units_outline);
	for (var k = 0; k < temp_unit_outline_map_size; k++) {
		// Check if Unit Exists
		if (!instance_exists(temp_unit_outline_index)) {
			continue;
		}
		
		// Unit Variables
		var temp_unit_outline_color = ds_map_find_value(units_outline, temp_unit_outline_index);
	
		// Reset Unit Select Surface Surface
		surface_set_target(unit_outline_surface);
		draw_clear_alpha(temp_unit_outline_color, 0);
	
		// Set Draw Variables
		var temp_health_show = temp_unit_outline_index.health_show;
		temp_unit_outline_index.health_show = false;
	
		// Combat Object Settings
		var temp_equip_weapon_attack_show = false;
		if (object_is_ancestor(temp_unit_outline_index.object_index, oUnitCombat) or (temp_unit_outline_index.object_index == oUnitCombat)) {
			// Firearm Attack Show
			for (var i = 0; i < ds_list_size(temp_unit_outline_index.inventory.weapons); i++) {
				// Find Indexed Weapon
				var temp_weapon_index = ds_list_find_value(temp_unit_outline_index.inventory.weapons, i);
	
				// Set Equipped Weapon Attack Show
				if (temp_weapon_index.equip) {
					temp_equip_weapon_attack_show = temp_weapon_index.attack_show;
					temp_weapon_index.attack_show = false;
					break;
				}
			}

			// Move Limb Positions
			for (var q = 0; q < temp_unit_outline_index.limbs; q++) {
				// Set Position
				temp_unit_outline_index.limb[q].limb_anchor_x -= (other.game_manager.camera_x - other.camera_offset_width);
				temp_unit_outline_index.limb[q].limb_anchor_y -= (other.game_manager.camera_y - other.camera_offset_height);
				temp_unit_outline_index.limb[q].point1_x -= (other.game_manager.camera_x - other.camera_offset_width);
				temp_unit_outline_index.limb[q].point1_y -= (other.game_manager.camera_y - other.camera_offset_height);
				temp_unit_outline_index.limb[q].point2_x -= (other.game_manager.camera_x - other.camera_offset_width);
				temp_unit_outline_index.limb[q].point2_y -= (other.game_manager.camera_y - other.camera_offset_height);
			}
		}
	
		for (var l = 0; l < array_length_1d(temp_unit_outline_index.layers); l++) {
			// Find Layer Elements
			var temp_layer_elements = layer_get_all_elements(temp_unit_outline_index.layers[l]);
			for (var i = 0; i < array_length_1d(temp_layer_elements); i++) {
				// Check if Element is an Instance
				if (layer_get_element_type(temp_layer_elements[i]) == layerelementtype_instance) {
					// Draw Instance
					var temp_inst = layer_instance_get_instance(temp_layer_elements[i]);
					with (temp_inst) {
						// Set Position
						x = x - (other.game_manager.camera_x - other.camera_offset_width);
						y = y - (other.game_manager.camera_y - other.camera_offset_height);
					
						// Draw Object
						event_perform(ev_draw, 0);
					
						// Reset Position
						x = x + (other.game_manager.camera_x - other.camera_offset_width);
						y = y + (other.game_manager.camera_y - other.camera_offset_height);
					}
				}
			}
		}
	
		// Reset Combat Object Settings
		if (object_is_ancestor(temp_unit_outline_index.object_index, oUnitCombat) or (temp_unit_outline_index.object_index == oUnitCombat)) {
			// Firearm Attack Show
			for (var i = 0; i < ds_list_size(temp_unit_outline_index.inventory.weapons); i++) {
				// Find Indexed Weapon
				var temp_weapon_index = ds_list_find_value(temp_unit_outline_index.inventory.weapons, i);
	
				// Set Equipped Weapon Attack Show
				if (temp_weapon_index.equip) {
					temp_weapon_index.attack_show = temp_equip_weapon_attack_show;
					break;
				}
			}
		
			// Reset Limb Positions
			for (var q = 0; q < temp_unit_outline_index.limbs; q++) {
				// Set Position Back
				temp_unit_outline_index.limb[q].limb_anchor_x += (other.game_manager.camera_x - other.camera_offset_width);
				temp_unit_outline_index.limb[q].limb_anchor_y += (other.game_manager.camera_y - other.camera_offset_height);
				temp_unit_outline_index.limb[q].point1_x += (other.game_manager.camera_x - other.camera_offset_width);
				temp_unit_outline_index.limb[q].point1_y += (other.game_manager.camera_y - other.camera_offset_height);
				temp_unit_outline_index.limb[q].point2_x += (other.game_manager.camera_x - other.camera_offset_width);
				temp_unit_outline_index.limb[q].point2_y += (other.game_manager.camera_y - other.camera_offset_height);
			}
		}
	
		// Reset Draw Variables
		temp_unit_outline_index.health_show = temp_health_show;
	
		// Reset Surface Target
		surface_reset_target();
	
		// Init Shader
		shader_set(shd_outline);

		shader_set_uniform_f(uniform_pixel_width, outline_texel_width);
		shader_set_uniform_f(uniform_pixel_height, outline_texel_height);
	
		// Draw Unit Select Surface to Overlay Surface
		surface_set_target(unit_outline_overlay_surface);
		draw_surface(unit_outline_surface, 0, 0);
		surface_reset_target();
	
		// Reset Shader
		shader_reset();
	
		// Update Unit Index
		temp_unit_outline_index = ds_map_find_next(units_outline, temp_unit_outline_index)
	}

	// Clear DS Map
	ds_map_clear(units_outline);
}

// Draw Overlay Surface
draw_x = game_manager.camera_x - camera_offset_width;
draw_y = game_manager.camera_y - camera_offset_height;