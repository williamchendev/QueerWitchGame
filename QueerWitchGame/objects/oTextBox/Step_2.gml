/// @description Insert description here
// You can write your code in this editor

// Box Breath & Triangle Rotate Draw Value
draw_val += box_breath_spd * global.deltatime;
if (draw_val >= 1) {
	draw_val--;
}
triangle_draw_angle = triangle_angle + (triangle_rotate_range * ((sin(draw_val * 2 * pi * triangle_rotate_spd) / 2) + 0.5));

// Input Variable
var temp_advance_input = keyboard_check_pressed(game_manager.interact_check);

// Increment Text Index
if (text_index <= string_length(text)) {
	// Input Advance
	if (input_advance) {
		if (instance_exists(game_manager)) {
			if (temp_advance_input) {
				text_index = string_length(text);
			}
		}
	}
	
	// Increment with Deltatime
	text_index += text_spd * global.deltatime;
}
else if (input_advance) {
	// Input Advance Destroy
	if (instance_exists(game_manager)) {
		if (temp_advance_input) {
			destroy = true;
		}
	}
}
else {
	// Timer Destroy
	destroy_timer += text_spd * global.deltatime;
	if (destroy_timer >= string_length(text) * text_read_timer_multiplier) {
		destroy = true;
	}
}
var temp_text_index = round(text_index);

// Destroy Behaviour
if (destroy) {
	destroy_alpha = lerp(destroy_alpha, 0, global.deltatime * fade_spd);
	if (destroy_alpha <= 0.05) {
		instance_destroy();
		return;
	}
	destroy_alpha = clamp(destroy_alpha, 0, 1);
}

// Reset Display Text
display_text = "";

// Add Words
var temp_text_index = 0;
var temp_text_split = split_string(text, " ");
for (var i = 0; i < array_length_1d(temp_text_split); i++) {
	// Add Length of Word
	temp_text_index += string_length(temp_text_split[i]);
	
	// Display Text Indexing Behaviour
	if (temp_text_index <= text_index) {
		// Index past Display Text
		if (i > 0) {
			display_text += " ";
		}
		display_text += temp_text_split[i];
	}
	else {
		// Vowel Parsing Behaviour
		if (vowel_parsing) {
			var temp_parse_text_length = text_index - (temp_text_index - string_length(temp_text_split[i]));
			for (var l = temp_parse_text_length; l >= 0; l--) {
				// Check for Vowels
				var temp_vowel = false;
				var temp_parse_char = string_lower(string_char_at(temp_text_split[i], l));
				for (var q = 0; q < array_length_1d(vowels); q++) {
					if (temp_parse_char == vowels[q]) {
						temp_vowel = true;
						break;
					}
				}
			
				// Add Vowel Segmented Word
				if (temp_vowel) {
					if (i > 0) {
						display_text += " ";
					}
		
					display_text += string_copy(temp_text_split[i], 0, l);
					break;
				}
			}
		}
		
		break;
	}
	
	// Increment Space
	temp_text_index++;
}

// Font Color
font_contrast_color = merge_color(font_color, c_black, 0.8);

// Follow Unit
if (unit != noone) {
	if (instance_exists(unit)) {
		unit_draw_x = unit.x - (sin(degtorad(unit.draw_angle)) * (unit.hitbox_right_bottom_y_offset - unit.hitbox_left_top_y_offset));
		unit_draw_y = unit.y - (unit.hitbox_right_bottom_y_offset - unit.hitbox_left_top_y_offset) - (unit.stats_y_offset * unit.draw_yscale);
	}
	else {
		unit = noone;
		if (interrupt_text_active) {
			if (random(1) < interrupt_text_chance) {
				var temp_random_text_index = irandom(array_length_1d(interrupt_text) - 1);
				text = interrupt_text[temp_random_text_index];
			
				text_index = 0;
				display_text = "";
				text_read_timer_multiplier = interrupt_text_read_timer_multiplier;
			
				y += interrupt_text_y_offset;
			
				destroy_timer = 0;
				destroy_alpha = 1;
				destroy = false;
			}
			else {
				destroy = true;
			}
		}
	}
}