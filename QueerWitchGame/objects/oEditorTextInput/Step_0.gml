/// @description Editor Text Input Update
// Calculates necessary functions for the text input

// Move Text Input with Camera
event_inherited();

// Clear Text
if (clear) {
	clear = false;
	
	text_input = reset;
	text_display = "";
	select_index = 0;
	text_show = 0;
}

// Set Font
draw_set_font(font);

// Selected Behaviours
if (selected) {
	// Line Timer
	line_timer -= 1;
	if (line_timer < 0) {
		line_timer = 50;
	}
	
	// Keyboard
	var reset_text = false;
	if (keyboard_check(vk_backspace)) {
		// Backspace
		if (backspace_timer <= 0) {
			// Delete Character at Select
			text_input = string_delete(text_input, select_index, 1);
			select_index--;
			if (select_index < text_show) {
				text_show--;
			}
			else if (select_index == text_show) {
				if (select_index == string_length(text_input)) {
					text_show = 0;
					reset_text = true;
				}
				else {
					text_show--;
				}
			}
			
			// Clamp Values and Reset Text
			if (select_index < 0) {
				select_index = 0;
			}
			if (text_show < 0) {
				text_show = 0;
			}
			
			// Reset Timer
			backspace_mode++;
			backspace_timer = 10;
		}
		else {
			if (backspace_mode > 8) {
				backspace_timer -= 7;
			}
			else if (backspace_mode > 2) {
				backspace_timer -= 4;
			}
			else {
				backspace_timer--;
			}
		}
	}
	else if (keyboard_check(vk_left)) {
		if (left_timer <= 0) {
			// Move Select Left
			select_index--;
			if (select_index < text_show) {
				text_show--;
			}
			else if (select_index == text_show) {
				if (select_index == string_length(text_input)) {
					text_show = 0;
					reset_text = true;
				}
				else {
					text_show--;
				}
			}
			
			// Clamp Values and Reset Text
			if (select_index < 0) {
				select_index = 0;
			}
			if (text_show < 0) {
				text_show = 0;
			}
			
			// Reset Timer
			left_mode++;
			left_timer = 10;
		}
		else {
			if (left_mode > 8) {
				left_timer -= 7;
			}
			else if (left_mode > 2) {
				left_timer -= 4;
			}
			else {
				left_timer--;
			}
		}
	}
	else if (keyboard_check(vk_right)) {
		if (right_timer <= 0) {
			// Move Select Right
			select_index++;
			if (select_index > string_length(text_input)) {
				select_index = string_length(text_input);
			}
			reset_text = true;
			
			// Reset Timer
			right_mode++;
			right_timer = 10;
		}
		else {
			if (right_mode > 8) {
				right_timer -= 7;
			}
			else if (right_mode > 2) {
				right_timer -= 4;
			}
			else {
				right_timer--;
			}
		}
	}
	else {
		// Set String Limit
		var temp_limit = string_length(text_input) + 3;
		if (text_limit > 0) {
			temp_limit = text_limit;
		}
		
		// Input Text
		if (string_length(text_input) < temp_limit) {
			if (use_alpha) {
				// Alphanumeric Characters (and the _ key)
				var temp_alpha = keyboard_check_letter();
				if (temp_alpha != noone) {
					if (temp_alpha != -1) {
						text_input = string_insert(temp_alpha, text_input, select_index + 1);
						select_index++;
						reset_text = true;
					}
				}
			}
			else {
				// Numeric Characters Only
				var temp_num = keyboard_check_number();
				if (temp_num >= 0) {
					text_input = string_insert(temp_num, text_input, select_index + 1);
					select_index++;
					reset_text = true;
				}
			}
		}
		
		backspace_timer = 0;
		backspace_mode = 0;
		left_timer = 0;
		left_mode = 0;
		right_timer = 0;
		right_mode = 0;
	}
	
	// Reset Show Index
	if (reset_text) {
		if (select_index > text_show) {
			if (string_width(string_copy(text_input, text_show, select_index - text_show)) > ((width - cutoff) - 4)) {
				for (var q = select_index + 1; q >= 0; q--) {
					var temp_check_length = string_copy(text_input, q, (select_index - q) + 1);
					if (string_width(temp_check_length) > (width - cutoff)) {
						break;
					}
					else {
						text_show = q;
					}
				}
			}
		}
	}
	
	if (mouse_check_button_pressed(mb_left)) {
		selected = false;
	}
}

// Click Event
if (mouse_check_button_pressed(mb_left)) {
	if (abs((x + (width / 2)) - mouse_room_x()) < width / 2) {
		if (abs((y + (height / 2)) - mouse_room_y()) < height / 2) {
			// Set Selected
			if (!selected) {
				// Reset Editor Input Selected
				with (oEditorInput) {
					selected = false;
				}
				// Set this Editor Input as Selected
				selected = true;
			}
			
			// Move Select Index towards Mouse Click
			var draw_x = x + 2;
			var new_index = 0;
			for (var i = 0; i <= string_length(text_display); i++) {
				var old_length_pos = string_width(string_copy(text_display, 0, new_index));
				var length_pos = string_width(string_copy(text_display, 0, i + 1));
				if (abs(mouse_room_x() - (draw_x + length_pos)) < abs(mouse_room_x() - (draw_x + old_length_pos))) {
					new_index = i;
				}
			}
			select_index  = new_index + text_show;
		}
	}
}

// Calculate Shown Text
var temp_text = "";
for (var i = text_show + 1; i <= string_length(text_input); i++) {
	var temp_check_length = temp_text + string_copy(text_input, i, 1);
	if (string_width(temp_check_length) > (width - cutoff)) {
		break;
	}
	else {
		temp_text += string_copy(text_input, i, 1);
	}
}
text_display = temp_text;