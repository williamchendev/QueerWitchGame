/// @description Level Generation
// Generates the new level from the Game Manager's settings

// Game FPS Cap
game_set_speed(60, gamespeed_fps);

// Generate Level
if (generate) {
	// Set Editor Data
	editorData();
	
	// Block Array Level Generation
	/*
	blocks[1] = "debug.txt";
	blocks[2] = "debug.txt";
	blocks[3] = "debug.txt";
	blocks[4] = "debug.txt";
	*/
	generate_blocks(blocks);
	
	// Reset Editor Data
	global.editor_data = noone;
	
	// Reset Instantiated Units List
	//ds_list_destroy(instantiated_units);
	//instantiated_units = ds_list_create();
}

// Reset Generate Function
generate = false;

// Init Surface Manager
var temp_sm_exists = false;
if (surface_manager != noone) {
	if (instance_exists(surface_manager)) {
		temp_sm_exists = true;
	}
}

if (!temp_sm_exists) {
	if (instance_number(oSurfaceManager) > 0) {
		surface_manager = instance_find(oSurfaceManager, 0);
	}
	else {
		surface_manager = instance_create_layer(0, 0, layer_get_id("Instances"), oSurfaceManager);
	}
}

// Reset Room Speed
time_spd = 1.0;