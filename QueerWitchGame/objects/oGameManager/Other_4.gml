/// @description Level Generation
// Generates the new level from the Game Manager's settings

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
}

// Reset Generate Function
generate = false;