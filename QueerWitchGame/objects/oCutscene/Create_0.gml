/// @description Insert description here
// You can write your code in this editor

// Cutscene Settings
cutscene_valid = false;
cutscene_enabled = true;

// File Settings
cutscene_file = noone;
if (file_name != "") {
	// Cutscene Data Directory
	var data_directory = string(program_directory +"\Data\\");
	
	if (!directory_exists(data_directory)) {
		show_error("Error: Cutscene Directory " + data_directory + " doesn't exist", false);
		instance_destroy();
		return;
	}
	
	// Load Cutscene File
	cutscene_file = file_text_open_read(data_directory + file_name + ".txt");
	
	if (cutscene_file == -1) {
		show_error("Error: Cutscene File " + file_name + ".txt doesn't exist", false);
		instance_destroy();
		return;
	}
	
	// Create Cutscene Data
	cutscene_data = ds_queue_create();
	
	// Index Cutscene Data
	while (!file_text_eof(cutscene_file)) {
		ds_queue_enqueue(cutscene_data, file_text_read_string(cutscene_file));
		file_text_readln(cutscene_file);
    }
	file_text_close(cutscene_file);
	
	// Cutscene Settings
	cutscene_valid = true;
	cutscene_variables = ds_map_create();
	cutscene_wait_unitpath = ds_list_create();
	cutscene_interrupt_units = ds_list_create();
}

// Cutscene Variables
cutscene_wait = false;
cutscene_wait_text = false;
cutscene_wait_timer = 0;

cutscene_dialogue_entity = noone;

// Interrupt Cutscene Variables
interrupt_text[0] = "Hey!";
interrupt_text[1] = "-ah!";
interrupt_text[2] = "-gh!";
interrupt_text[3] = "wwhat?!";
interrupt_text[4] = "-hha!";
interrupt_text[5] = "There!";
interrupt_text[6] = "Get down!";
interrupt_text[7] = "hey HEY!";
interrupt_text[8] = "-ffuck!";
interrupt_text[9] = "Hhhh!";

// Debug
sprite_index = -1;