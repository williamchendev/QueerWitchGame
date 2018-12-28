/// debugInventoryPopulationFill(inventory_object);
/// @description Takes an inventory object and populates the inventory array data with random formatted indexes
/// @param {real} inventory_object The given inventory object to populate with indexes

var temp_inven_obj = argument0;

randomize();

for (var h = 0; h < temp_inven_obj.inventory_height; h++) {
	for (var w = 0; w < temp_inven_obj.inventory_width; w++) {
		if (temp_inven_obj.inventory[w, h] == 0) {
			var temp_width = irandom_range(1, 3);
			var temp_height = irandom_range(1, 3);
			
			var can_write_values = true;
			for (var i = 0; i < 2; i++) {
				for (var yi = 0; yi < temp_height; yi++) {
					for (var xi = 0; xi < temp_width; xi++) {
						var temp_x = w + xi;
						var temp_y = h + yi;
						if (i == 0) {
							if (!(temp_x < 0 or temp_x >= temp_inven_obj.inventory_width)) {
								if (!(temp_y < 0 or temp_y >= temp_inven_obj.inventory_height)) {
									if (temp_inven_obj.inventory[temp_x, temp_y] != 0) {
										can_write_values = false;
									}
								}
								else {
									can_write_values = false;
								}
							}
							else {
								can_write_values = false;
							}
						}
						else {
							temp_inven_obj.inventory[temp_x, temp_y] = (-1 * (w + (h * temp_inven_obj.inventory_width))) - 1;
						}
					}
				}
				
				if (!can_write_values) {
					break;
				}
			}
			
			if (can_write_values) {
				temp_inven_obj.inventory[w, h] = 1;
			}
		}
	}
}