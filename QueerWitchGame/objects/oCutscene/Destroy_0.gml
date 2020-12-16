/// @description Insert description here
// You can write your code in this editor

// Garbage Collection
if (cutscene_valid) {
	ds_queue_destroy(cutscene_data);
	cutscene_data = -1;

	ds_map_destroy(cutscene_variables);
	cutscene_variables = -1;
	
	ds_list_destroy(cutscene_wait_unitpath);
	cutscene_wait_unitpath = -1;
	
	ds_list_destroy(cutscene_interrupt_units);
	cutscene_interrupt_units = -1;
}