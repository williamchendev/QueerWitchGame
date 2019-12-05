/// @description Inventory Update Event
// performs all the calculations for the inventory behavior & draw events

// Inventory Menu Calculations
if (draw_inventory) {
	// Sin Radial Calculations
	sin_val += radial_spd;
	if (sin_val > 1) {
		sin_val = 0;
	}
	var draw_sin = (sin(sin_val * 2 * pi) / 2) + 1;
	
	// Set Inventory Menu Alpha
	draw_alpha = lerp(draw_alpha, 1, draw_lerp_spd);
	
	// Calculate Inventory Position & Properties
	draw_inventory_x = x + (-32 * (1 - (draw_alpha * draw_alpha)));
	draw_inventory_y = y - ((inventory_height / 2) * inventory_grid_size) - inventory_offset_size - inventory_outline_size;
	draw_inventory_outline_size = (inventory_offset_size * draw_sin) + inventory_outline_size;
	
	// Player Input
	var key_left_press = false;
	var key_right_press = false;
	var key_up_press = false;
	var key_down_press = false;

	var key_select_press = false;
	var key_cancel_press = false;
	var key_menu_press = false;

	if (game_manager != noone) {
		if (draw_inventory_open) {
			key_left_press = keyboard_check_pressed(game_manager.left_check);
			key_right_press = keyboard_check_pressed(game_manager.right_check);
			key_up_press = keyboard_check_pressed(game_manager.up_check);
			key_down_press = keyboard_check_pressed(game_manager.down_check);
		
			key_select_press = keyboard_check_pressed(game_manager.select_check);
			key_cancel_press = keyboard_check_pressed(game_manager.cancel_check);
			key_menu_press = keyboard_check_pressed(game_manager.menu_check);
		}
	}
	
	// Select position variables
	var select_x = select_index % inventory_width;
	var select_y = select_index div inventory_width;
	var temp_selected_width = 1;
	var temp_selected_height = 1;
	if (inventory[select_x, select_y] != 0) {
		temp_selected_width = select_target_width;
		temp_selected_height = select_target_height;
	}
	
	// Input Calculations
	var update_inventory = false;
	if (select_place) {
		// Place a specific number of stacks down on a specific tile
		if (key_up_press or key_right_press) {
			select_place_num++;
			if (select_place_num > select_item_stacks) {
				select_place_num = 1;
			}
		}
		else if (key_down_press or key_left_press) {
			select_place_num--;
			if (select_place_num < 1) {
				select_place_num = select_item_stacks;
			}	
		}
			
		if (key_select_press) {
			if (checkItemInventory(self, select_x, select_y, select_item_width, select_item_height, select_item_id, select_place_num)) {
				// Place Item in empty inventory space
				placeItemInventory(self, select_item_id, select_x, select_y, select_place_num);
				
				select_item_stacks -= select_place_num;
				
				// Reset select item properties
				if (select_item_stacks <= 0) {
					select_item_id = 0;
					select_item_stacks = 0;
					
					select_item_width = 0;
					select_item_height = 0;
			
					select_place = false;
					select_place_num = 0;
				}
				select_place = false;
				select_place_num = 0;
			}
		}
		else if (key_cancel_press) {
			select_place = false;
			select_place_num = 0;
		}
	}
	else {
		if (key_select_press) {
			// Moving around Items in Inventory
			if (draw_inventory_open) {
				if (select_item_id == 0) {
					if (inventory[select_x, select_y] > 0) {
						// Set select item properties
						select_item_id = inventory[select_x, select_y];
						select_item_stacks = inventory_stacks[select_x, select_y];
					
						select_item_width = temp_selected_width;
						select_item_height = temp_selected_height;
						
						// Set select Weapon properties
						if (global.item_data[select_item_id, itemstats.type] == itemtypes.weapon) {
							for (var q = 0; q < ds_list_size(weapons_index); q++) {
								if (ds_list_find_value(weapons_index, q) == select_index) {
									weapon_place_index = q;
									break;
								}
							}
						}
					
						// Reset inventory spaces
						for (var h = 0; h < select_item_height; h++) {
							for (var w = 0; w < select_item_width; w++) {
								inventory[w + select_x, h + select_y] = 0;
							}
						}
						inventory_stacks[select_x, select_y] = 0;
						update_inventory = true;
					}
				}
				else {
					if (checkItemInventory(self, select_x, select_y, select_item_width, select_item_height, select_item_id)) {
						if (select_item_stacks == 1 && checkItemInventory(self, select_x, select_y, select_item_width, select_item_height, select_item_id, 1)) {	
							// Place Item in empty inventory space
							placeItemInventory(self, select_item_id, select_x, select_y);
							
							// Update Weapon Index
							if (weapon_place_index != -1) {
								ds_list_set(weapons_index, weapon_place_index, select_index);
								weapon_place_index = -1;
							}
							
							// Reset select item properties
							select_item_id = 0;
							select_item_stacks = 0;
					
							select_item_width = 0;
							select_item_height = 0;
					
							// Update Inventory
							update_inventory = true;
							draw_inventory_open = false;
						}
						else if (select_item_stacks != 1) {
							select_place = true;
							select_place_num = select_item_stacks;
						}
					}
				}
			}
		}
		else if (key_cancel_press) {
			if (select_item_id != 0) {
				// Place Item back into the inventory
				addItemInventory(self, select_item_id, select_item_stacks);
					
				// Reset select item properties
				select_item_id = 0;
				select_item_stacks = 0;
					
				select_item_width = 0;
				select_item_height = 0;
				
				// Delete redundant weapon index
				if (weapon_place_index != -1) {
					ds_list_delete(weapons, weapon_place_index);
					ds_list_delete(weapons_index, weapon_place_index);
					weapon_place_index = -1;
				}
			
				// Update Inventory
				update_inventory = true;
			}
		}
		else {
			// Move Inventory Selection Index
			if (select_item_id == 0) {
				// Move Select Cursor when nothing is selected
				if (key_up_press) {
					select_y--;
					if (select_y < 0) {
						select_y = inventory_height - 1;
					}
				}
				else if (key_down_press) {
					select_y += temp_selected_height;
					if (select_y >= inventory_height) {
						select_y = 0;
					}
				}
	
				if (key_left_press) {
					select_x--;
					if (select_x < 0) {
						select_x = inventory_width - 1;
					}
				}
				else if (key_right_press) {
					select_x += temp_selected_width;
					if (select_x >= inventory_width) {
						select_x = 0;
					}
				}
	
				if (inventory[select_x, select_y] < 0) {
					var temp_select_x = select_x;
					var temp_select_y = select_y;
					select_x = (-1 * (inventory[temp_select_x, temp_select_y] + 1)) % inventory_width;
					select_y = (-1 * (inventory[temp_select_x, temp_select_y] + 1)) div inventory_width;
				}
			}
			else {
				// Move Select Cursor when something is selected
				if (key_up_press) {
					select_y--;
					if (select_y < 0) {
						select_y = inventory_height - select_item_height;
					}
				}
				else if (key_down_press) {
					select_y++;
					if (select_y + select_item_height - 1 >= inventory_height) {
						select_y = 0;
					}
				}
	
				if (key_left_press) {
					select_x--;
					if (select_x < 0) {
						select_x = inventory_width - select_item_width;
					}
				}
				else if (key_right_press) {
					select_x++;
					if (select_x + select_item_width - 1 >= inventory_width) {
						select_x = 0;
					}
				}
			}
		}
	}
	
	var temp_early_index = select_index;
	select_index = select_x + (select_y * inventory_width);
	if (!draw_inventory_open or update_inventory) {
		temp_early_index = select_index + 1;
	}
	
	// Update Select Index & Select movement targets
	if (temp_early_index != select_index) {
		// Update Sizes of Select Target Width & Height
		var temp_select_width = 1;
		var temp_select_height = 1;
		if (inventory[select_x, select_y] != 0) {
			for (var w = select_x + 1; w < inventory_width; w++) {
				if (inventory[w, select_y] == (-1 * select_index) - 1) {
					temp_select_width++;
				}
				else {
					break;
				}
			}
			for (var h = select_y + 1; h < inventory_height; h++) {
				if (inventory[select_x, h] == (-1 * select_index) - 1) {
					temp_select_height++;
				}
				else {
					break;
				}
			}
		}
		
		select_target_width = temp_select_width;
		select_target_height = temp_select_height;
	}
	select_xpos = lerp(select_xpos, (select_x * inventory_grid_size), draw_lerp_spd);
	select_ypos = lerp(select_ypos, (select_y * inventory_grid_size), draw_lerp_spd);
	select_width = lerp(select_width, select_target_width * inventory_grid_size, draw_lerp_spd);
	select_height = lerp(select_height, select_target_height * inventory_grid_size, draw_lerp_spd);
	if (select_item_id != 0) {
		select_can_place = checkItemInventory(self, select_x, select_y, select_item_width, select_item_height, select_item_id);
	}
	
	// Open Inventory Initialization & Reset
	if (!draw_inventory_open) {
		select_xpos = (select_x * inventory_grid_size);
		select_ypos = (select_y * inventory_grid_size);
		select_width = select_target_width * inventory_grid_size;
		select_height = select_target_height * inventory_grid_size;
		draw_inventory_open = true;
	}
}
else {
	// Set Inventory Menu Alpha
	draw_alpha = lerp(draw_alpha, 0, draw_lerp_spd);
	
	// Reset Inventory Initialization
	if (draw_inventory_open) {
		if (select_item_id != 0) {
			// Place Item back into inventory
			addItemInventory(self, select_item_id, select_item_stacks);
					
			// Reset select item properties
			select_item_id = 0;
			select_item_stacks = 0;
					
			select_item_width = 0;
			select_item_height = 0;
			
			// Delete redundant weapon index
			if (weapon_place_index != -1) {
				ds_list_delete(weapons, weapon_place_index);
				ds_list_delete(weapons_index, weapon_place_index);
				weapon_place_index = -1;
			}
			
			update_inventory = true;
		}
		select_place = false;
	}
	draw_inventory_open = false;
}