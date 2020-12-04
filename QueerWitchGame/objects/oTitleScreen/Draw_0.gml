/// @description Title Screen Draw Event
// Draws the Title Screen to the Screen

// Draw Options Screen
if (options_active) {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fInnoFont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(game_manager.game_width / 2, game_manager.game_height / 2, options_text);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	return;
}

// Draw Credits Screen
if (credits_active) {
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_font(fInnoFont);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(game_manager.game_width / 2, game_manager.game_height / 2, credits_text);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	return;
}

// Draw Deadname Title
var temp_color_blend = merge_color(deadname_title_color, c_white, deadname_title_alpha * deadname_title_alpha * deadname_title_alpha * deadname_title_alpha * deadname_title_alpha);
var temp_color_alpha = deadname_title_alpha * deadname_title_alpha * deadname_title_alpha;
var temp_title_lerp_y_pos = lerp((game_manager.game_height / 2) - 36, (sprite_get_height(deadname_title_sprite) / 2) + deadname_title_y_offset, deadname_title_alpha);
draw_sprite_ext(deadname_title_sprite, 0, game_manager.game_width / 2, temp_title_lerp_y_pos, 1, 1, 0, temp_color_blend, temp_color_alpha);

// Draw "Inno Spelman" Text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fInnoFont);
draw_text(inno_spelman_text_x_offset, inno_spelman_text_y_offset, inno_spelman_draw_text);

// Draw Title Buttons
draw_set_alpha((inno_spelman_text_alpha * inno_spelman_text_alpha) * 0.5);

if (button_index != 0) {
	draw_sprite(play_button_sprite, 0, game_manager.game_width / 2, (game_manager.game_height / 2) + play_button_sprite_y_offset);
}
else {
	draw_sprite(play_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x1, ((game_manager.game_height / 2) + play_button_sprite_y_offset) + button_move_offset_y1);
	draw_set_alpha(1);
	draw_sprite(play_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x2, ((game_manager.game_height / 2) + play_button_sprite_y_offset) + button_move_offset_y2);
	draw_set_alpha((inno_spelman_text_alpha * inno_spelman_text_alpha) * 0.5);
}

if (button_index != 1) {
	draw_sprite(options_button_sprite, 0, game_manager.game_width / 2, (game_manager.game_height / 2) + options_button_sprite_y_offset);
}
else {
	draw_sprite(options_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x1, ((game_manager.game_height / 2) + options_button_sprite_y_offset) + button_move_offset_y1);
	draw_set_alpha(1);
	draw_sprite(options_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x2, ((game_manager.game_height / 2) + options_button_sprite_y_offset) + button_move_offset_y2);
	draw_set_alpha((inno_spelman_text_alpha * inno_spelman_text_alpha) * 0.5);
}

if (button_index != 2) {
	draw_sprite(credits_button_sprite, 0, game_manager.game_width / 2, (game_manager.game_height / 2) + credits_button_sprite_y_offset);
}
else {
	draw_sprite(credits_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x1, ((game_manager.game_height / 2) + credits_button_sprite_y_offset) + button_move_offset_y1);
	draw_set_alpha(1);
	draw_sprite(credits_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x2, ((game_manager.game_height / 2) + credits_button_sprite_y_offset) + button_move_offset_y2);
	draw_set_alpha((inno_spelman_text_alpha * inno_spelman_text_alpha) * 0.5);
}

if (button_index != 3) {
	draw_sprite(end_button_sprite, 0, game_manager.game_width / 2, (game_manager.game_height / 2) + end_button_sprite_y_offset);
}
else {
	draw_sprite(end_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x1, ((game_manager.game_height / 2) + end_button_sprite_y_offset) + button_move_offset_y1);
	draw_set_alpha(1);
	draw_sprite(end_button_sprite, 0, (game_manager.game_width / 2) + button_move_offset_x2, ((game_manager.game_height / 2) + end_button_sprite_y_offset) + button_move_offset_y2);
	draw_set_alpha((inno_spelman_text_alpha * inno_spelman_text_alpha) * 0.5);
}

// Draw Play Fade Effect
if (play_active) {
	var temp_play_fade_lerp = lerp(0, game_manager.game_width + 40, (play_fade_timer * play_fade_timer) + 0.2);
	draw_set_alpha(1);
	draw_set_color(c_black);
	draw_triangle(0, 0, 0, game_manager.game_height, temp_play_fade_lerp, 0, false);
	draw_triangle(game_manager.game_width, 0, game_manager.game_width, game_manager.game_height, game_manager.game_width - temp_play_fade_lerp, game_manager.game_height, false);
}

// Reset Draw Variables
draw_set_alpha(1);
draw_set_color(c_white);