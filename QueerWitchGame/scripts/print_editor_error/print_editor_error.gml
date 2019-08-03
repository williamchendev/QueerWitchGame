/// print_editor_error(string, title);
/// @description Creates a new error window in the editor with the given body of text
/// @param {string} string The body of text for the error message
/// @param {string} title Optionally set the title for the error message

// Establish Variables
var temp_text = argument[0];
var temp_title = "Error";
if (argument_count > 1) {
	var temp_title = argument[1];
}

// Create the new Error Window
draw_set_font(fNormalFont);
temp_text = format_string_width(temp_text, 180);
var temp_error = instance_create_layer(x, y, layer_get_id("Editor_UI"), oEditorErrorWindow);
temp_error.height = string_height(temp_text) + 8;
temp_error.body_text = temp_text;
temp_error.window_title = temp_title;