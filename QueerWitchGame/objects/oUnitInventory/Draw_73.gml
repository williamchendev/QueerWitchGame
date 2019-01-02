/// @description Inventory GUI Draw Event
// draws the GUI Inventory Menu to the screen

// Skips drawing inventory unless GUI mode is active
if (!draw_inventory) {
	exit;
}

// Draw Inventory
var temp_x = draw_inventory_x + inventory_offset_size + inventory_outline_size;
var temp_y = draw_inventory_y + inventory_offset_size + inventory_outline_size;
draw_set_alpha(draw_alpha * draw_alpha);
if (draw_sprite_index == noone) {
	// Draw blank inventory without sprite
	draw_set_color(c_black);
	draw_roundrect(temp_x - draw_inventory_outline_size, temp_y - draw_inventory_outline_size, temp_x + (inventory_width * inventory_grid_size) + draw_inventory_outline_size, temp_y + (inventory_height * inventory_grid_size) + draw_inventory_outline_size, false);
}

// Draw all Items in Inventory
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
for (var h = 0; h < inventory_height; h++) {
	for (var w = 0; w < inventory_width; w++) {
		if (inventory[w, h] > 0) {
			// Draw Item Sprite
			draw_sprite(global.item_data[inventory[w, h], itemstats.sprite_index], global.item_data[inventory[w, h], itemstats.image_index], temp_x + (w * inventory_grid_size), temp_y + (h * inventory_grid_size));
			// Draw Item Stack
			if (inventory_stacks[w, h] > 1) {
				var temp_item_width = global.item_data[inventory[w, h], itemstats.width_space] * inventory_grid_size;
				var temp_item_height = global.item_data[inventory[w, h], itemstats.height_space] * inventory_grid_size;
				
				draw_set_font(fHeartBit);
				drawTextOutline(temp_x + temp_item_width + (w * inventory_grid_size) - 1, temp_y + temp_item_height + (h * inventory_grid_size), c_white, c_black, inventory_stacks[w, h]);
			}
		}
	}
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Draw Select Cursor
var temp_cursor_x = temp_x + select_xpos;
var temp_cursor_y = temp_y + select_ypos;
if (select_item_id != 0) {
	// Draw Select Cursor with Item
	var temp_can_place_color = c_white;
	if (!select_can_place) {
		temp_can_place_color = make_color_rgb(224,18,95);
	}
	var temp_item_offset = 2;
	draw_sprite_ext(global.item_data[select_item_id, itemstats.sprite_index], global.item_data[select_item_id, itemstats.image_index], temp_cursor_x + temp_item_offset, temp_cursor_y + temp_item_offset, 1, 1, 0, temp_can_place_color, 0.8 * draw_alpha);
	
	// Draw placing stacks in inventory
	if (select_place) {
		var temp_cursor_y_h = temp_y + select_ypos + select_height;
		draw_set_font(fHeartBit);
		drawTextOutline(temp_cursor_x + temp_item_offset, temp_cursor_y_h + temp_item_offset, c_white, c_black, "How many to place?\n" + string(select_place_num) + " out of " + string(select_item_stacks));
	}
	else if (select_item_stacks > 1) {
		var temp_item_width = global.item_data[select_item_id, itemstats.width_space] * inventory_grid_size;
		var temp_item_height = global.item_data[select_item_id, itemstats.height_space] * inventory_grid_size;
		
		draw_set_halign(fa_right);
		draw_set_valign(fa_bottom);
		draw_set_font(fHeartBit);
		drawTextOutline(temp_cursor_x + temp_item_offset + temp_item_width - 1, temp_cursor_y + temp_item_offset + temp_item_height, c_white, c_black, string(select_item_stacks));
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
	}
}
else {
	// Draw Four Cornered Cursor
	var temp_cursor_x_w = temp_x + select_xpos + select_width;
	var temp_cursor_y_h = temp_y + select_ypos + select_height;
	draw_sprite_ext(sInventorySelect, 0, temp_cursor_x, temp_cursor_y, 1, 1, 0, c_white, draw_alpha * draw_alpha * draw_alpha);
	draw_sprite_ext(sInventorySelect, 0, temp_cursor_x_w, temp_cursor_y, 1, 1, 270, c_white, draw_alpha * draw_alpha * draw_alpha);
	draw_sprite_ext(sInventorySelect, 0, temp_cursor_x_w, temp_cursor_y_h, 1, 1, 180, c_white, draw_alpha * draw_alpha * draw_alpha);
	draw_sprite_ext(sInventorySelect, 0, temp_cursor_x, temp_cursor_y_h, 1, 1, 90, c_white, draw_alpha * draw_alpha * draw_alpha);
	
	// Draw Name and Description of Item being hovered over
	var select_xi = select_index % inventory_width;
	var select_yi = select_index div inventory_width;
	if (inventory[select_xi, select_yi] > 0) {
		var temp_desc_x = ((select_index % inventory_width) * inventory_grid_size) + temp_x;
		var temp_desc_length = (game_manager.camera_x + game_manager.camera_width) - temp_desc_x - 16;
		
		draw_set_font(fHeartBit);
		drawTextOutline(temp_cursor_x, temp_cursor_y_h, c_white, c_black, global.item_data[inventory[select_xi, select_yi], itemstats.name]);
		drawTextOutline(temp_cursor_x, temp_cursor_y_h + 14, c_white, c_black, "\"" + format_string_width(global.item_data[inventory[select_xi, select_yi], itemstats.description] + "\"", temp_desc_length));
	}
}

// **DEBUG DRAWCODE**
draw_set_color(c_black);
draw_set_font(-1);
var select_xi = select_index % inventory_width;
var select_yi = select_index div inventory_width;
draw_text(x - 40, y, select_index);
draw_text(x - 40, y + 12, "x:" + string(select_xi));
draw_text(x - 40, y + 24, "y:" + string(select_yi));
draw_text(x - 40, y + 36, "id:" + string(inventory[select_xi, select_yi]));
draw_text(x - 40, y + 48, "stack:" + string(inventory_stacks[select_xi, select_yi]));

// Reset drawing variables
draw_set_color(c_white);
draw_set_alpha(1);