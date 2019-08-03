/// @description New Block Window Step
// Calculates the behaviour of the New Block File Window

// Inherit the parent event
event_inherited();

// Check if Pressed
if (!destroyed) {
	if (elements[3].pressed) {
		elements[3].pressed = false;
		
		// Check length of Block Params
		if (string_length(elements[0].text_input) <= 0) {
			print_editor_error("Error: width parameter is empty!", "Invalid Param");
			return;
		}
		if (string_length(elements[1].text_input) <= 0) {
			print_editor_error("Error: height parameter is empty!", "Invalid Param");
			return;
		}
		if (string_length(elements[2].text_input) <= 0) {
			print_editor_error("Error: file name parameter is empty!", "Invalid Param");
			return;
		}
	
		// Block Variables
		var temp_width = real(string_digits(elements[0].text_input));
		var temp_height = real(string_digits(elements[1].text_input));
		var temp_filename = elements[2].text_input;
		
		// Check if User Parameters are valid
		if (temp_width < min_block_width) {
			elements[0].clear = true;
			elements[0].reset = string(min_block_width);
			print_editor_error("Error: Width is too small, the minimum width is " + string(min_block_width), "Invalid Width");
			return;
		}
		if (temp_height < min_block_height) {
			elements[1].clear = true;
			elements[1].reset = string(min_block_height);
			print_editor_error("Error: Height is too small, the minimum height is " + string(min_block_height), "Invalid Height");
			return;
		}
		if (temp_width > max_block_width) {
			elements[0].clear = true;
			elements[0].reset = string(max_block_width);
			print_editor_error("Error: Width is too large, the maximum width is " + string(max_block_width), "Invalid Width");
			return;
		}
		if (temp_height > max_block_height) {
			elements[1].clear = true;
			elements[1].reset = string(max_block_height);
			print_editor_error("Error: Height is too large, the maximum height is " + string(max_block_height), "Invalid Height");
			return;
		}
		
		// Create New Block
		if (instance_exists(oEditorStartMenu)) {
			instance_destroy(oEditorStartMenu);
		}
		
		oEditor.x = -33;
		oEditor.y = -20;
		
		var camera = view_camera[0];
		camera_set_view_pos(camera, oEditor.x, oEditor.y);
		
		oEditor.block_tileset_index = 0;
		oEditor.block_tileset = tilesetCreate(0, 0, temp_width, temp_height, layer_get_id("Tiles"), global.editor_entity_data[1, 0]);
		
		oEditor.editor_tools = instance_create_layer(oEditor.x + oGameManager.camera_width - 20, oEditor.y + 20, layer_get_id("Editor_UI"), oEditorUtilBar);
		oEditor.editor_objects = instance_create_layer(oEditor.x, oEditor.y, layer_get_id("Editor_UI"), oEditorObjectSelectMenu);
		
		oEditor.editor_mode = editortypes.block;
		
		oEditor.block_width = temp_width;
		oEditor.block_height = temp_height;
		oEditor.block_filename = temp_filename;
		
		// Delete Window & Elements
		destroyed = true;
		for (var i = 0; i < array_length_1d(elements); i++) {
			instance_destroy(elements[i].id);
		}
		instance_destroy(id);
	}
}