/// @description Platform Destroy Event
// Performs the necessary calculations to uninstantiate this platform

ds_list_destroy(units);
ds_list_destroy(enemies);
units = -1;
enemies = -1;
return;