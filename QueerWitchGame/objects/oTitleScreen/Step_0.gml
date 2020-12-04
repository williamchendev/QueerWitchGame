/// @description Title Screen Update Event
// Calculates the Title Screen behaviour

// Player Input
var temp_click = mouse_check_button_pressed(mb_left);

// Play Screen Behaviour
if (play_active) {
	temp_click = false;
	
	play_fade_timer += play_fade_spd * global.realdeltatime;
	play_fade_timer = clamp(play_fade_timer, 0, 1);
	if (play_fade_timer == 1) {
		room_goto(play_room_goto);
		return;
	}
}

// Options Screen Behaviour
if (options_active) {
	if (temp_click) {
		options_active = false;
		temp_click = false;
	}
	else {
		return;
	}
}

// Credits Screen Behaviour
if (credits_active) {
	if (temp_click) {
		credits_active = false;
		temp_click = false;
	}
	else {
		return;
	}
}

// Deadname Title Alpha
if (deadname_title_alpha < 1) {
	deadname_title_alpha += global.realdeltatime * deadname_title_alpha_spd;
	deadname_title_alpha = clamp(deadname_title_alpha, 0, 1);
}

// Inno Spelman Text Alpha
if (deadname_title_alpha >= 0.8) {
	if (inno_spelman_text_alpha < 1) {
		inno_spelman_text_alpha += global.realdeltatime * inno_spelman_text_alpha_spd;
		inno_spelman_text_alpha = clamp(inno_spelman_text_alpha, 0, 1);
	}
}
inno_spelman_draw_text = string_copy(inno_spelman_text, 0, round(string_length(inno_spelman_text) * inno_spelman_text_alpha));

// Title Menu Button Variables
var temp_menu_x = (game_manager.game_width / 2);

var temp_play_button_y = (game_manager.game_height / 2) + play_button_sprite_y_offset;
var temp_play_button_width = (sprite_get_width(play_button_sprite) / 2);
var temp_play_button_height = (sprite_get_height(play_button_sprite) / 2);

var temp_options_button_y = (game_manager.game_height / 2) + options_button_sprite_y_offset;
var temp_options_button_width = (sprite_get_width(options_button_sprite) / 2);
var temp_options_button_height = (sprite_get_height(options_button_sprite) / 2);

var temp_credits_button_y = (game_manager.game_height / 2) + credits_button_sprite_y_offset;
var temp_credits_button_width = (sprite_get_width(credits_button_sprite) / 2);
var temp_credits_button_height = (sprite_get_height(credits_button_sprite) / 2);

var temp_end_button_y = (game_manager.game_height / 2) + end_button_sprite_y_offset;
var temp_end_button_width = (sprite_get_width(end_button_sprite) / 2);
var temp_end_button_height = (sprite_get_height(end_button_sprite) / 2);

// Title Menu Button Behaviour
if (deadname_title_alpha >= 1) {
	// Mouse Hover
	button_index = -1;
	if (point_in_rectangle(mouse_x, mouse_y, temp_menu_x - temp_play_button_width, temp_play_button_y - temp_play_button_height, temp_menu_x + temp_play_button_width, temp_play_button_y + temp_play_button_height)) {
		button_index = 0;
	}
	else if (point_in_rectangle(mouse_x, mouse_y, temp_menu_x - temp_options_button_width, temp_options_button_y - temp_options_button_height, temp_menu_x + temp_options_button_width, temp_options_button_y + temp_options_button_height)) {
		button_index = 1;
	}
	else if (point_in_rectangle(mouse_x, mouse_y, temp_menu_x - temp_credits_button_width, temp_credits_button_y - temp_credits_button_height, temp_menu_x + temp_credits_button_width, temp_credits_button_y + temp_credits_button_height)) {
		button_index = 2;
	}
	else if (point_in_rectangle(mouse_x, mouse_y, temp_menu_x - temp_end_button_width, temp_end_button_y - temp_end_button_height, temp_menu_x + temp_end_button_width, temp_end_button_y + temp_end_button_height)) {
		button_index = 3;
	}
}

if (button_index != -1) {
	if (temp_click) {
		if (button_index == 0) {
			play_active = true;
		}
		else if (button_index == 1) {
			options_active = true;
		}
		else if (button_index == 2) {
			credits_active = true;
		}
		else if (button_index == 3) {
			// Exit Game
			game_end();
		}
	}
}

// Title Menu Button Movement
button_move_timer += title_button_move_spd * global.realdeltatime;
if (button_move_timer >= 1) {
	while (button_move_timer >= 1) {
		button_move_timer--;
	}
	
	button_move_offset_x1 = random_range(-title_button_move_range, title_button_move_range);
	button_move_offset_y1 = random_range(-title_button_move_range, title_button_move_range);
	button_move_offset_x2 = random_range(-title_button_move_range, title_button_move_range);
	button_move_offset_y2 = random_range(-title_button_move_range, title_button_move_range);
}

// Debug
if (keyboard_check_pressed(ord("L"))) {
	room_restart();
}