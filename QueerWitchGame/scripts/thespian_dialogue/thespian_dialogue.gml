/// thespian_dialogue(text_data);
/// @description Thespian dialogue method, given a text argument to create a textbox off of
/// @param {string} text_data The text data to create a textbox from
/// @returns {real} Returns an entity (object index) of the textbox object created with the given argument

// Assemble Variables
var temp_text_data = argument[0];

// Grammars
var temp_text = string_replace_all(temp_text_data, "\#nl\#", "\n");

// Create Textbox
var temp_textbox_obj = instance_create_layer(0, 0, layer_get_name("Instances"), oTextBox);
temp_textbox_obj.text = temp_text;

// Return Textbox
return temp_textbox_obj;