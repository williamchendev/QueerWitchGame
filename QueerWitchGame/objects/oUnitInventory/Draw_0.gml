/// @description Insert description here
// You can write your code in this editor

// Skip drawing inventory unless set to draw
draw_self();
if (!draw_inventory) {
	exit;
}

// Draw Inventory
draw_set_color(c_black);
draw_rectangle(x, y, x + 20, y + 20, false);
for (var h = 0; h < inventory_height; h++) {
	for (var w = 0; w < inventory_width; w++) {
		var temp_start_x = x + (w * 10);
		var temp_start_y = y + (h * 10);
		draw_rectangle(temp_start_x, temp_start_y, temp_start_x + 10, temp_start_y + 10, false);
	}
}

// Reset drawing variables
draw_set_color(c_white);