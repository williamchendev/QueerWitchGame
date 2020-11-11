/// @description Unit Late Update Event
// performs the late calculations necessary for the Unit's behavior

// Update Unit Inventory
if (inventory != noone) {
	// Sprite Variables
	var temp_y_scale = (image_yscale * draw_yscale);
	var temp_mask_height = sprite_get_bbox_bottom(sprite_index) - sprite_get_bbox_top(sprite_index);
	
	// Set Inventory visual features
	inventory.x = lerp(inventory.x, x + inventory_x_offset, inventory_lerp_spd * global.realdeltatime);
	inventory.y = lerp(inventory.y, y + lengthdir_y(temp_mask_height * 0.5 * temp_y_scale, draw_angle + 90), inventory_lerp_spd * global.realdeltatime);
	inventory.draw_inventory = inventory_show;
}

// Debug Reset Room
if (keyboard_check_pressed(ord("L"))) {
	ds_list_destroy(game_manager.instantiated_units);
	game_manager.instantiated_units = ds_list_create();
	room_restart();
}