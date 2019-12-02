/// @description Inventory Destroy Event
// destroys the unnecessary variables and data structures for the clean up

// Destroy DS Lists
for (var i = ds_list_size(weapons) - 1; i >= 0; i--) {
	var temp_weapon = ds_list_find_value(weapons, i);
	instance_destroy(temp_weapon);
	ds_list_set(weapons, i, noone);
}
ds_list_destroy(weapons);
ds_list_destroy(weapons_index);
weapons = -1;
weapons_index = -1;
return;