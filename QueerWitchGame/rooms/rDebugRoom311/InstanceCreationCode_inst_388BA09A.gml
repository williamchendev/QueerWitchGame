addItemInventory(inventory, 8);
addItemInventory(inventory, 7, 6);
var temp_weapon = ds_list_find_value(inventory.weapons, 0);
temp_weapon.equip = true;