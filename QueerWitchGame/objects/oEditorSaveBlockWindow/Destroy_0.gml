/// @description Save Block Window Destroy
// Destroys the Save Block Window and Closes the file being read

// Close Opened File
if (file_write) {
	file_text_close(file);
}

// Print Error Message
if (!file_write_finished) {
	print_editor_error("File \"" + file_name + "\" incompletely saved");
}

// Inherit the parent event
event_inherited();