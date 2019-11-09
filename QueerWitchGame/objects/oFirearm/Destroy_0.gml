/// @description Firearm DS Cleanup
// Clears the Firearm Data Structures on the destroy event

ds_list_destroy(flash_timer);
ds_list_destroy(flash_length);
ds_list_destroy(flash_direction);
ds_list_destroy(flash_xposition);
ds_list_destroy(flash_yposition);
ds_list_destroy(flash_imageindex);
flash_timer = -1;
flash_length = -1;
flash_direction = -1;
flash_xposition = -1;
flash_yposition = -1;
flash_imageindex = -1;