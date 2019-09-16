/// @description New Block Window Step
// Calculates the behaviour of the New Block File Window

// Write File
if (file_write) {
	// Write Modes
	if (!file_write_objects) {
		// Write Block General Data
		file_text_write_string(file, gen_save_lines[progress_index]);
		file_text_writeln(file);
		progress_index++;
		progress_text = "Saving Block Data";
		
		// Switch Write Mode
		if (progress_index == gen_save_index) {
			file_write_objects = true;
		}
	}
	else {
		if (file_object_mode == 0) {
			// Check if Solids Exist
			if (instance_exists(oEditorObjectSolid)) {
				// Create Solids
				var temp_write_line = "";
			
				// Get Solid Object Data
				var temp_object = instance_find(oEditorObjectSolid, file_object_index);
				temp_write_line = "\#" + string(temp_object.object_editor_id) + ", x: " + string(temp_object.x) + ", y: " + string(temp_object.y) + ", angle: " + string(temp_object.object_rotation) + ", x_scale: " + string(temp_object.object_x_scale) + ", y_scale: " + string(temp_object.object_y_scale);
			
				// Write Solid to File
				file_text_write_string(file, temp_write_line);
				file_text_writeln(file);
				progress_text = "Solids: \#" + string(temp_object.object_editor_id);
				progress_index++;
			}
			file_object_index++;
			
			// Change Object Mode
			if (file_object_index >= instance_number(oEditorObjectSolid)) {
				// Write Object Spacer to File
				file_text_write_string(file, "");
				file_text_writeln(file);
				file_text_write_string(file, "// Objects");
				file_text_writeln(file);
				file_text_write_string(file, "num: " + string(instance_number(oEditorObjectObject)));
				file_text_writeln(file);
				
				// Reset
				file_object_mode = 1;
				file_object_index = 0;
			}
		}
		else if (file_object_mode == 1) {
			// Check if Objects Exist
			if (instance_exists(oEditorObjectObject)) {
				// Create Objects
				var temp_write_line = "";
			
				// Get Object Data
				var temp_object = instance_find(oEditorObjectObject, file_object_index);
				temp_write_line = "\#" + string(temp_object.object_editor_id) + ", x: " + string(temp_object.x) + ", y: " + string(temp_object.y) + ", angle: " + string(temp_object.object_rotation) + ", x_scale: " + string(temp_object.object_x_scale) + ", y_scale: " + string(temp_object.object_y_scale);
			
				// Write Object to File
				file_text_write_string(file, temp_write_line);
				file_text_writeln(file);
				progress_text = "Objects: \#" + string(temp_object.object_editor_id);
				progress_index++;
			}
			file_object_index++;
			
			// Change Object Mode
			if (file_object_index >= instance_number(oEditorObjectObject)) {
				// Reset
				file_object_mode = -1;
				file_object_index = 0;
			}
		}
		else {
			file_write_finished = true;
			instance_destroy();
			return;
		}
	}
}
else {
	// Open Write Mode
	file = file_text_open_write(file_name_full + ".txt");
	// Check if File Invalid
	if (file != -1) {
		file_write = true;
	}
	else {
		instance_destroy();
	}
}

// Check Progress
progress = progress_index / progress_max;
progress = clamp(progress, 0, 1);

// Progress Dots
progress_dot_timer++;
if (progress_dot_timer >= 10) {
	progress_dots++;
	if (progress_dots >= 3) {
		progress_dots = 0;
	}
	progress_dot_timer = 0;
}

// Inherit the parent event
event_inherited();