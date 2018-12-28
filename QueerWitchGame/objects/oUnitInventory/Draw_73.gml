/// @description Inventory GUI Draw Event
// draws the GUI Inventory Menu to the screen

// Skips drawing inventory unless GUI mode is active
if (!draw_inventory) {
	exit;
}

// Draw Inventory
var temp_x = draw_inventory_x + inventory_offset_size;
var temp_y = draw_inventory_y + inventory_offset_size;
draw_set_alpha(draw_alpha * draw_alpha);
if (draw_sprite_index == noone) {
	// Draw blank inventory without sprite
	draw_set_color(c_black);
	draw_roundrect(temp_x - draw_inventory_outline_size, temp_y - draw_inventory_outline_size, temp_x + (inventory_width * (inventory_grid_size + inventory_grid_space_size)) + draw_inventory_outline_size, temp_y + (inventory_height * (inventory_grid_size + inventory_grid_space_size)) + draw_inventory_outline_size - 1, false);
}

// **DEBUG DRAWCODE**
for (var h = 0; h < inventory_height; h++) {
	for (var w = 0; w < inventory_width; w++) {
		if (inventory[w, h] != 0) {
			draw_set_color(c_blue);
			draw_rectangle(temp_x + (w * (inventory_grid_size + inventory_grid_space_size)), temp_y + (h * (inventory_grid_size + inventory_grid_space_size)), temp_x + ((w + 1) * (inventory_grid_size + inventory_grid_space_size)) - 1, temp_y + ((h + 1) * (inventory_grid_size + inventory_grid_space_size)) - 1, false);
			draw_set_color(c_white);
			draw_text(temp_x + (w * (inventory_grid_size + inventory_grid_space_size)), temp_y + (h * (inventory_grid_size + inventory_grid_space_size)), inventory[w, h]);
		}
	}
}
draw_set_color(c_black);
var select_xi = select_index % inventory_width;
var select_yi = select_index div inventory_width;
draw_text(x - 40, y, select_index);
draw_text(x - 40, y + 12, "x:" + string(select_xi));
draw_text(x - 40, y + 24, "y:" + string(select_yi));

draw_set_color(c_red);
draw_rectangle(temp_x + select_xpos, temp_y + select_ypos, temp_x + select_xpos + select_width, temp_y + select_ypos + select_height, true);
//var temp_select_x = select_index % inventory_width;
//var temp_select_y = select_index div inventory_width;
//var t_x = temp_x + (temp_select_x * (inventory_grid_size + inventory_grid_space_size));
//var t_y = temp_y + (temp_select_y * (inventory_grid_size + inventory_grid_space_size));
//draw_rectangle(t_x, t_y, t_x + 10, t_y + 10, false);

// Reset drawing variables
draw_set_color(c_white);
draw_set_alpha(1);