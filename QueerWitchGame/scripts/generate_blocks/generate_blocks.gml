/// generate_blocks(file_paths);
/// @description Generates a level from the array of block file paths and stiches the levels together
/// @param {array} file_paths The block file paths in an array to generate and stitch into a level

// Function Variables
var temp_file_paths = argument0;

// Block Variables
var temp_blocks = array_length_1d(temp_file_paths);

var temp_block_settings = ds_grid_create(temp_blocks, 4);
var temp_block_tiledata = ds_list_create();
var temp_block_solids = ds_list_create();
var temp_block_objects = ds_list_create();

// Read Block Data
for (var i = 0; i < temp_blocks; i++) {
	// Open File
	var temp_block = temp_file_paths[i];
	var temp_block_file = file_text_open_read(oGameManager.data_directory + temp_block);
	file_text_readln(temp_block_file);
	
	// Block Data
	var temp_width = real(string_digits(file_text_readln(temp_block_file)));
	var temp_height = real(string_digits(file_text_readln(temp_block_file)));
	var temp_origin = real(string_digits(file_text_readln(temp_block_file)));
	file_text_readln(temp_block_file);
	file_text_readln(temp_block_file);
	ds_grid_set(temp_block_settings, i, 0, temp_width);
	ds_grid_set(temp_block_settings, i, 1, temp_height);
	ds_grid_set(temp_block_settings, i, 2, temp_origin);
	
	// Tileset Data
	var temp_tileset = real(string_digits(file_text_readln(temp_block_file)));
	ds_grid_set(temp_block_settings, i, 3, temp_tileset);
	
	var temp_tiledata = noone;
	for (var h = 0; h < temp_height; h++) {
		// Split Tileset Data from Raw Line
		var temp_tile_raw = file_text_readln(temp_block_file);
		temp_tile_raw = string_replace_all(temp_tile_raw, " ", "");
		var temp_split_tiles = split_string(temp_tile_raw, ",");
		
		// Read Raw Data from Line
		for (var w = 0; w < array_length_1d(temp_split_tiles) - 1; w++) {
			var temp_tile = real(string_replace(temp_split_tiles[w], ",", ""));
			temp_tiledata[w, h] = temp_tile;
		}
	}
	file_text_readln(temp_block_file);
	file_text_readln(temp_block_file);
	ds_list_add(temp_block_tiledata, temp_tiledata);
	
	// Solids Data
	var temp_solids_num = real(string_digits(file_text_readln(temp_block_file)));
	var temp_solidsdata = noone;
	for (var h = 0; h < temp_solids_num; h++) {
		// Split Solid Raw Data
		var temp_solids_raw = file_text_readln(temp_block_file);
		var temp_solids_split = split_string(temp_solids_raw, ",");
		
		// Store Solids Data
		temp_solidsdata[h, 0] = string_digitsdecimal(temp_solids_split[0]); // ID
		temp_solidsdata[h, 1] = string_digitsdecimal(temp_solids_split[1]); // X Position
		temp_solidsdata[h, 2] = string_digitsdecimal(temp_solids_split[2]); // Y Position
		temp_solidsdata[h, 3] = string_digitsdecimal(temp_solids_split[3]); // Angle
		temp_solidsdata[h, 4] = string_digitsdecimal(temp_solids_split[4]); // X Scale
		temp_solidsdata[h, 5] = string_digitsdecimal(temp_solids_split[5]); // Y Scale
	}
	file_text_readln(temp_block_file);
	file_text_readln(temp_block_file);
	ds_list_add(temp_block_solids, temp_solidsdata);
	
	// Object Data
	var temp_objects_num = real(string_digits(file_text_readln(temp_block_file)));
	var temp_objectsdata = noone;
	for (var h = 0; h < temp_objects_num; h++) {
		// Split Solid Raw Data
		var temp_objects_raw = file_text_readln(temp_block_file);
		var temp_objects_split = split_string(temp_objects_raw, ",");
		
		// Store Solids Data
		temp_objectsdata[h, 0] = string_digitsdecimal(temp_objects_split[0]); // ID
		temp_objectsdata[h, 1] = string_digitsdecimal(temp_objects_split[1]); // X Position
		temp_objectsdata[h, 2] = string_digitsdecimal(temp_objects_split[2]); // Y Position
		temp_objectsdata[h, 3] = string_digitsdecimal(temp_objects_split[3]); // Angle
		temp_objectsdata[h, 4] = string_digitsdecimal(temp_objects_split[4]); // X Scale
		temp_objectsdata[h, 5] = string_digitsdecimal(temp_objects_split[5]); // Y Scale
	}
	file_text_readln(temp_block_file);
	file_text_readln(temp_block_file);
	ds_list_add(temp_block_objects, temp_objectsdata);
	
	// Close File
	file_text_close(temp_block_file);
}

// Generate Level Tileset
var temp_level_x = 0;
for (var q = 0; q < temp_blocks; q++) {
	// Block Data
	var temp_width = ds_grid_get(temp_block_settings, q, 0);
	var temp_height = ds_grid_get(temp_block_settings, q, 1);
	var temp_origin = ds_grid_get(temp_block_settings, q, 2);
	var temp_ts_index = ds_grid_get(temp_block_settings, q, 3);
	
	// Generate Block Tiles
	var temp_tileset_index = global.editor_data[global.editor_data_categories_length + temp_ts_index, 0];
	var temp_new_tileset = tilesetCreate(temp_level_x, temp_origin * 48, temp_width, temp_height, layer_get_id("Tiles"), temp_tileset_index, c_white, 1);
	var temp_tiledata_tileset = ds_list_find_value(temp_block_tiledata, q);
	for (var h = 0; h < temp_height; h++) {
		for (var w = 0; w < temp_width; w++) {
			tilesetSet(temp_new_tileset, w, h, temp_tiledata_tileset[w, h]);
		}
	}
	temp_level_x += temp_width * 48;
}

// Generate Level Solids
var temp_level_x = 0;
for (var q = 0; q < temp_blocks; q++) {
	// Block Data
	var temp_width = ds_grid_get(temp_block_settings, q, 0);
	var temp_origin = ds_grid_get(temp_block_settings, q, 2);
	
	// Generate Block Solids
	var temp_block_solidsdata = ds_list_find_value(temp_block_solids, q);
	for (var k = 0; k < array_height_2d(temp_block_solidsdata); k++) {
		// Get Solids Data
		var temp_id = temp_block_solidsdata[k, 0];
		var temp_x_position = temp_block_solidsdata[k, 1];
		var temp_y_position = temp_block_solidsdata[k, 2];
		var temp_angle = temp_block_solidsdata[k, 3];
		var temp_x_scale = temp_block_solidsdata[k, 4];
		var temp_y_scale = temp_block_solidsdata[k, 5];
		
		// Create Solid
		var temp_object = instance_create_layer(temp_level_x + temp_x_position, (temp_origin * 48) + temp_y_position, layer_get_id("Instances"), global.editor_data[temp_id, 0]);
		temp_object.image_angle = temp_angle;
		temp_object.image_xscale = temp_x_scale;
		temp_object.image_yscale = temp_y_scale;
	}
	
	temp_level_x += temp_width * 48;
}

// Generate Level Objects
var temp_level_x = 0;
for (var q = 0; q < temp_blocks; q++) {
	// Block Data
	var temp_width = ds_grid_get(temp_block_settings, q, 0);
	var temp_origin = ds_grid_get(temp_block_settings, q, 2);
	
	// Generate Block Objects
	var temp_block_objectsdata = ds_list_find_value(temp_block_objects, q);
	for (var k = 0; k < array_height_2d(temp_block_objectsdata); k++) {
		// Get Objects Data
		var temp_id = temp_block_objectsdata[k, 0];
		var temp_x_position = temp_block_objectsdata[k, 1];
		var temp_y_position = temp_block_objectsdata[k, 2];
		var temp_angle = temp_block_objectsdata[k, 3];
		var temp_x_scale = temp_block_objectsdata[k, 4];
		var temp_y_scale = temp_block_objectsdata[k, 5];
		
		// Create Object
		var temp_object = instance_create_layer(temp_level_x + temp_x_position, (temp_origin * 48) + temp_y_position, layer_get_id("Instances"), global.editor_data[temp_id, 0]);
		temp_object.image_angle = temp_angle;
		temp_object.image_xscale = temp_x_scale;
		temp_object.image_yscale = temp_y_scale;
	}
	
	temp_level_x += temp_width * 48;
}

// Clear DS Variables
ds_grid_destroy(temp_block_settings);
ds_list_destroy(temp_block_tiledata);
ds_list_destroy(temp_block_solids);
ds_list_destroy(temp_block_objects);