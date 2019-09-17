/// @description New Block Window Init
// Creates the settings for the New Block File Window

// Inherit the parent event
event_inherited();

// File Settings
file = noone;
file_name = oEditor.filename;
file_name_full = oGameManager.data_directory + oEditor.sub_directory + oEditor.filename;

file_write = false;
file_write_objects = false;
file_write_finished = false;

file_object_mode = 0;
file_object_index = 0;

// General Collected Save Data
gen_save_index = 0;

gen_save_lines[0] = "// Block File Settings";
gen_save_lines[1] = "width: " + string(oEditor.block_width);
gen_save_lines[2] = "height: " + string(oEditor.block_height);
gen_save_lines[3] = "origin: " + string(oEditor.block_origin);
gen_save_lines[4] = "";

gen_save_lines[5] = "// Tileset Data";
gen_save_lines[6] = "tileset_index: " + string(oEditor.block_tileset_index);
gen_save_index = 7;
for (var h = 0; h < oEditor.block_tileset.height; h++) {
	var temp_tileset_string = "";
	for (var w = 0; w < oEditor.block_tileset.width; w++) {
		var temp_tileset_string_length = string_length(string(oEditor.block_tileset.tile_index[w, h]));
		var temp_tileset_space = string_repeat(" ", 3 - temp_tileset_string_length);
		var temp_tileset_endspace = " ";
		if (w == (oEditor.block_tileset.width - 1)) {
			temp_tileset_endspace = "";
		}
		temp_tileset_string += temp_tileset_space + string(oEditor.block_tileset.tile_index[w, h]) + "," + temp_tileset_endspace;
	}
	gen_save_lines[gen_save_index] = temp_tileset_string;
	gen_save_index++;
}
gen_save_lines[gen_save_index] = "";

gen_save_lines[gen_save_index + 1] = "// Solids";
gen_save_lines[gen_save_index + 2] = "num: " + string(instance_number(oEditorObjectSolid));
gen_save_index += 3;

// Save Draw Variables
progress = 0;
progress_index = 0;
progress_max = gen_save_index + instance_number(oEditorObject);

progress_text = "";
progress_dots = 0;
progress_dot_timer = 0;

// Settings
window_title = "Save Block File";

width = 220;
height = 35;

camera_x_offset = (oGameManager.camera_width / 2) - (width / 2);
camera_y_offset = (oGameManager.camera_height / 2) - (height / 2);
x = oGameManager.camera_x + camera_x_offset;
y = oGameManager.camera_y + camera_y_offset;