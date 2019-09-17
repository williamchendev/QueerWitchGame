/// @description Play Demo Window Step
// Calculates the behaviour of the Play Demo Window

// Inherit the parent event
event_inherited();

// Check if Pressed
if (!destroyed) {
	if (elements[1].pressed) {
		elements[1].pressed = false;
		
		// Check length of Block Params
		if (string_length(elements[0].text_input) <= 0) {
			print_editor_error("Error: file path parameter is empty!", "Invalid Param");
			return;
		}
		
		// Check if File Exists
		var temp_filepath = elements[0].text_input + ".txt";
		if (!file_exists(oGameManager.data_directory + temp_filepath)) {
			print_editor_error("Error: file \"" + elements[0].text_input + "\" not found", "File I/O Error");
			return;
		}
		
		// Generate Demo
		var temp_filepaths = noone;
		temp_filepaths[0] = temp_filepath;
		
		oGameManager.generate = true;
		oGameManager.blocks = temp_filepaths;
		
		// Destroy Editor Objects
		if (instance_exists(oEditor)) {
			instance_destroy(oEditor);
		}
		if (instance_exists(oEditorStartMenu)) {
			instance_destroy(oEditorStartMenu);
		}
		
		// Delete Window & Elements
		destroyed = true;
		for (var i = 0; i < array_length_1d(elements); i++) {
			instance_destroy(elements[i].id);
		}
		instance_destroy(id);
		
		// Switch Room
		room_goto(rLevelDemo);
	}
}