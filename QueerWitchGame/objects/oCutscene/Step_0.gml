/// @description Insert description here
// You can write your code in this editor

// Cutscene Behaviour
if (cutscene_valid and cutscene_enabled) {
	// Cutscene Check Interrupt Units
	var temp_interrupted = false;
	if (ds_list_size(cutscene_interrupt_units) > 0) {
		for (var i = 0; i < ds_list_size(cutscene_interrupt_units); i++) {
			var temp_interrupted = false;
			var temp_interrupt_unit = ds_list_find_value(cutscene_interrupt_units, i);
			if (instance_exists(temp_interrupt_unit)) {
				if (temp_interrupt_unit.alert >= 1) {
					temp_interrupted = true;
				}
			}
			else {
				temp_interrupted = true;
			}
			
			if (temp_interrupted) {
				break;
			}
		}
	}
	
	// Cutscene Interrupt Behaviour
	if (temp_interrupted) {
		if (cutscene_dialogue_entity != noone) {
			if (instance_exists(cutscene_dialogue_entity)) {
				if (cutscene_dialogue_entity.input_advance) {
					// Destroy Input Advance Dialogue
					cutscene_dialogue_entity.destroy = true;
				}
				else {
					// Interrupted Conversation Dialogue
					if (cutscene_dialogue_entity.unit != noone) {
						if (instance_exists(cutscene_dialogue_entity.unit)) {
							if (array_length_1d(interrupt_text) > 0) {
								// Reset Dialogue Textbox
								var temp_interrupted_conversation_text = interrupt_text[irandom(array_length_1d(interrupt_text) - 1)];
								with (cutscene_dialogue_entity) {
									text = temp_interrupted_conversation_text;
									text_index = 0;
									display_text = "";
									destroy_timer = 0;
									destroy_alpha = 1;
									destroy = false;
								}
							}
						}
					}
				}
			}
		}
		
		// Destroy & End Cutscene
		instance_destroy();
		return;
	}
	
	// Cutscene Wait Behaviour
	if (cutscene_wait) {
		// Wait Types
		if (cutscene_wait_text) {
			// Cutscene Text Advance
			if (cutscene_dialogue_entity != noone) {
				if (!instance_exists(cutscene_dialogue_entity)) {
					// Break from Wait Text Behaviour
					cutscene_wait = false;
					cutscene_wait_text = false;
					cutscene_dialogue_entity = noone;
				}
				else {
					// Skip Event
					return;
				}
			}
			else {
				// Break from Wait Text Behaviour
				cutscene_wait = false;
				cutscene_wait_text = false;
			}
		}
		else if (ds_list_size(cutscene_wait_unitpath) > 0) {
			// Cutscene Units
			for (var q = ds_list_size(cutscene_wait_unitpath) - 1; q >= 0; q--) {
				var temp_wait_path_unit = ds_list_find_value(cutscene_wait_unitpath, q);
				if (!temp_wait_path_unit.pathing) {
					ds_list_delete(cutscene_wait_unitpath, q);
				}
			}
			
			// Repeat Event
			if (ds_list_size(cutscene_wait_unitpath) <= 0) {
				event_perform(ev_step_normal, 0);
				return;
			}
		}
		else {
			// Cutscene Wait Timer
			cutscene_wait_timer -= global.deltatime;
			if (cutscene_wait_timer <= 0) {
				cutscene_wait_timer = 0;
				cutscene_wait = false;
			}
			else {
				// Skip Event
				return;
			}
		}
	}
	
	// Execute Cutscene Data Line Behaviour
	while (!ds_queue_empty(cutscene_data)) {
		// Line Data
		var temp_data_line = ds_queue_dequeue(cutscene_data);
		
		// Comment Break & Empty Line Check
		if (string_copy(temp_data_line, 0, 2) == "//") {
			continue;
		}
		if (string_replace_all(temp_data_line, " ", "") == "") {
			continue;
		}
		
		// Split Line Data
		var temp_data_line_length = string_length(temp_data_line);
		var temp_semi_pos = string_pos(":", temp_data_line);
		if (temp_semi_pos != 0) {
			if (string_char_at(temp_data_line, temp_semi_pos + 1) == ":") {
				temp_semi_pos++;
			}
			temp_data_line_length = temp_semi_pos;
		}
		
		var temp_data_line_on_space = false;
		var temp_data_line_removed_duplicate_spaces = "";
		for (var temp_char = 1; temp_char <= temp_data_line_length; temp_char++) {
			// Delete Spaces within Line
			if ((string_char_at(temp_data_line, temp_char) == "(") and (string_char_at(temp_data_line, max(temp_char - 1, 0)) != " ") and (string_char_at(temp_data_line, max(temp_char - 1, 0)) != "\"")) {
				// Method Behaviour
				for (var temp_char_method = temp_char; temp_char_method <= string_length(temp_data_line); temp_char_method++) {
					if (string_char_at(temp_data_line, temp_char_method) == ")") {
						temp_data_line_removed_duplicate_spaces += string_char_at(temp_data_line, temp_char_method);
						temp_char = temp_char_method;
						break;
					}
					else if (string_char_at(temp_data_line, temp_char_method) != " ") {
						temp_data_line_removed_duplicate_spaces += string_char_at(temp_data_line, temp_char_method);
					}
				}
			}
			else if (string_char_at(temp_data_line, temp_char) == " ") {
				// Space Behaviour
				if (!temp_data_line_on_space) {
					temp_data_line_removed_duplicate_spaces += string_char_at(temp_data_line, temp_char);
					temp_data_line_on_space = true;
				}
			}
			else {
				// Non-Space Behaviour
				temp_data_line_removed_duplicate_spaces += string_char_at(temp_data_line, temp_char);
				temp_data_line_on_space = false;
			}
		}
		
		// Line Words Parsing
		var temp_data_string_words = split_string(temp_data_line_removed_duplicate_spaces, " ");
		
		if (array_length_1d(temp_data_string_words) > 0) {
			// Word Variables
			var temp_data_words = ds_list_create();
			var temp_data_words_type = ds_list_create();
			
			// Iterate through Words
			var i = 0;
			while (i < array_length_1d(temp_data_string_words)) {
				// Parse individual words as methods, syntax, or variables
				var temp_word_string = temp_data_string_words[i];
				ds_list_add(temp_data_words, temp_word_string);
				
				// Word Method Check
				if ((string_pos("(", temp_word_string) != 0) and (string_pos(")", temp_word_string) != 0)) {
					// Parse Method Function
					var temp_method_name = string_copy(temp_word_string, 0, string_pos("(", temp_word_string) - 1);
					ds_list_add(temp_data_words_type, "method_" + temp_method_name);
					
					// Parse Method Arguments
					temp_word_string = string_copy(temp_word_string, string_pos("(", temp_word_string), string_pos(")", temp_word_string));
					ds_list_set(temp_data_words, i, temp_word_string);
					
					// Interate to Next Word
					i++;
					continue;
				}
				
				// Word Sytax Check
				var temp_word_is_syntax = true;
				var temp_word_is_dialogue_syntax = false;
				switch (temp_word_string) {
					case "if":
						ds_list_add(temp_data_words_type, "syntax");
						break;
					case "else":
						ds_list_add(temp_data_words_type, "syntax");
						break;
					case "=":
						ds_list_add(temp_data_words_type, "syntax");
						break;
					case ":":
					case "::":
						ds_list_add(temp_data_words_type, "syntax");
						temp_word_is_dialogue_syntax = true;
						break;
					default:
						temp_word_is_syntax = false;
						break;
				}
				
				if (temp_word_is_dialogue_syntax) {
					// Index Dialogue Words
					var temp_dialogue_start_pos = string_pos(":", temp_data_line) + 1;
					if (string_char_at(temp_data_line, temp_dialogue_start_pos) == ":") {
						temp_dialogue_start_pos++;
					}
					var temp_dialogue = string_copy(temp_data_line, temp_dialogue_start_pos, (string_length(temp_data_line) - temp_dialogue_start_pos) + 1);
					if (string_char_at(temp_dialogue, 0) == " ") {
						temp_dialogue = string_copy(temp_dialogue, 2, string_length(temp_dialogue) + 1);
					}
					ds_list_add(temp_data_words, temp_dialogue);
					ds_list_add(temp_data_words_type, "dialogue");
					
					// Break
					i++;
					break;
				}
				if (temp_word_is_syntax) {
					// Iterate to next Word
					i++;
					continue;
				}
				
				// Word Variable Check
				if (is_undefined(ds_map_find_value(cutscene_variables, temp_word_string))) {
					ds_map_add(cutscene_variables, temp_word_string, noone);
				}
				ds_list_add(temp_data_words_type, "variable");
				
				// Increment Index
				i++;
			}
			
			// Line Behaviour
			if (ds_list_size(temp_data_words) > 2) {
				// Three Words Type Checks
				switch (ds_list_find_value(temp_data_words_type, 0)) {
					case "variable":
						// First Word Variable
						switch (ds_list_find_value(temp_data_words, 1)) {
							case "=":
								// Set Variable Behaviour
								var temp_variable_value = noone;
								switch (ds_list_find_value(temp_data_words_type, 2)) {
									case "variable":
										// Get Variable Value
										temp_variable_value = ds_map_find_value(cutscene_variables, ds_list_find_value(temp_data_words, 2));
										break;
									case "method_find":
										// Get Value from Find Method
										temp_variable_value = thespian_find(self, ds_list_find_value(temp_data_words, 2));
										break;
									default :
										// Invalid Statement
										break;
								}
								ds_map_replace(cutscene_variables, ds_list_find_value(temp_data_words, 0), temp_variable_value);
								
								// End
								break;
							case ":":
							case "::":
								// Set Dialogue Behaviour
								cutscene_dialogue_entity = thespian_dialogue(ds_list_find_value(temp_data_words, 2));
								if (ds_map_find_value(cutscene_variables, ds_list_find_value(temp_data_words, 0)) != noone) {
									var temp_textbox_unit = ds_map_find_value(cutscene_variables, ds_list_find_value(temp_data_words, 0));
									if (temp_textbox_unit.object_index == oUnit or object_is_ancestor(temp_textbox_unit.object_index, oUnit)) {
										cutscene_dialogue_entity.unit = temp_textbox_unit;
									}
								}
								
								// Set Dialogue Input Advance
								cutscene_wait_text = true; // DEBUG REMOVE
								if (ds_list_find_value(temp_data_words, 1) == "::") {
									cutscene_dialogue_entity.input_advance = true;
									cutscene_wait_text = true;
									cutscene_wait = true;
									return;
								}
								
								// End
								break;
							default :
								// Invalid Statement
								break;
						}
						
						// End
						break;
					default:
						// Invalid Statement
						break;
				}
			}
			else if (ds_list_size(temp_data_words) > 1) {
				// Two Words Type Checks
			}
			else if (ds_list_size(temp_data_words) > 0) {
				// One Words Type Checks
				switch (ds_list_find_value(temp_data_words_type, 0)) {
					case "method_wait":
						// Wait Method Behaviour
						thespian_wait(self, ds_list_find_value(temp_data_words, 0));
						if (cutscene_wait) {
							return;
						}
						break;
					case "method_move":
						// Move Method Behaviour
						thespian_move(self, ds_list_find_value(temp_data_words, 0));
						break;
					case "method_interrupt":
						// Interrupt Method Behaviour
						var temp_arguments = thespian_parse(self, ds_list_find_value(temp_data_words, 0));
						
						// Index Interrupt Units
						for (var l = 0; l < array_length_1d(temp_arguments); l++) {
							ds_list_add(cutscene_interrupt_units, temp_arguments[l]);
						}
						break;
					default:
						// Invalid Statement
						break;
				}
			}
			
			// Debug
			/*
			for (var i = 0; i < ds_list_size(temp_data_words); i++) {
				show_debug_message(ds_list_find_value(temp_data_words, i));
				show_debug_message(ds_list_find_value(temp_data_words_type, i));
			}
			*/
			
			// Garbage Collection
			ds_list_destroy(temp_data_words_type);
			ds_list_destroy(temp_data_words);
			temp_data_words_type = -1;
			temp_data_words = -1;
		}
		
	}
	
	// Destroy Cutscene Object
	if (ds_queue_empty(cutscene_data)) {
		instance_destroy();
	}
}

/*
if (cutscene_index < array_length_1d(cutscene_actions)) {
	cutscene_actions[cutscene_index].active = true;
	if (cutscene_actions[cutscene_index].complete) {
		with (cutscene_actions[cutscene_index]) {
			instance_destroy();
		}
		cutscene_index++;
	}
}
*/