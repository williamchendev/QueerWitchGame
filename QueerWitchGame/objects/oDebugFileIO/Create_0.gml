/// @description Insert description here
// You can write your code in this editor

// Creating Directories
var data_directory = string(program_directory +"\Data\\");

if (!directory_exists(data_directory)) {
	directory_create(data_directory);
}

show_debug_message(data_directory);

// File Data
var block_width = 5;
var block_height = 6;
var ground_axis = 2;

var tileset_index = 0;

// Creating Files
var file_name = data_directory + "temp_block.txt";
var file = file_text_open_write(file_name);

// Block Settings
file_text_write_string(file, "// Block Settings");
file_text_writeln(file);
file_text_write_string(file, "width: " + string(block_width) + ";");
file_text_writeln(file);
file_text_write_string(file, "height: " + string(block_height) + ";");
file_text_writeln(file);
file_text_write_string(file, "ground_axis: " + string(ground_axis) + ";");
file_text_writeln(file);
file_text_writeln(file);

// Physics
file_text_write_string(file, "// Physics");
file_text_writeln(file);
for (var h = 0; h < block_height; h++) {
	for (var w = 0; w < block_width; w++) {
		file_text_write_string(file, "0,");
	}
	file_text_writeln(file);
}
file_text_writeln(file);

// Tileset
file_text_write_string(file, "// Tileset");
file_text_writeln(file);
file_text_write_string(file, "tilset_index: " + string(tileset_index) + ";");
file_text_writeln(file);
for (var h = 0; h < block_height; h++) {
	for (var w = 0; w < block_width; w++) {
		file_text_write_string(file, "0,");
	}
	file_text_writeln(file);
}
file_text_writeln(file);

// Paths
file_text_write_string(file, "// Paths");
file_text_writeln(file);
file_text_write_string(file, "It ain't done yet");
file_text_writeln(file);
file_text_writeln(file);

// Objects
file_text_write_string(file, "// Objects");
file_text_writeln(file);
file_text_write_string(file, "10000, x: 27, y: 60;");
file_text_writeln(file);
file_text_write_string(file, "20000, x: 38, y: 90, layer: background;");
file_text_writeln(file);
file_text_write_string(file, "30000, x: 100, y: 28, layer: background;");
file_text_writeln(file);
file_text_writeln(file);

// Close File
file_text_close(file);