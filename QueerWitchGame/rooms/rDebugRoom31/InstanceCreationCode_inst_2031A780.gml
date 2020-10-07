addItemInventory(inventory, 8);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;
//var temp_gun = ds_list_find_value(inventory.weapons, 0);
temp_weapon.draw_debug = true;