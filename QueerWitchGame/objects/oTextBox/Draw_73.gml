/// @description Insert description here
// You can write your code in this editor

// Check if Text Exists
if (string_length(display_text) <= 0) {
	return;
}

// Set Font Properties
draw_set_font(font);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Set Alpha
draw_set_alpha(destroy_alpha * destroy_alpha);

// Text Variables
var temp_breath_padding = clamp(((sin(draw_val * 2 * pi) / 2) + 0.5), box_breath_edge_clamp, 1 - box_breath_edge_clamp) * box_breath_padding;
var temp_text_separation = text_separation + string_height("ABCDEFGHIJKLMNOPQRSTUVWYXZ");
var temp_text_width = (string_width_ext(display_text, temp_text_separation, text_wrap_width) / 2) + (box_horizontal_padding / 2) + temp_breath_padding;
var temp_text_height = (string_height_ext(display_text, temp_text_separation, text_wrap_width) / 2) + (box_vertical_padding / 2) + temp_breath_padding;

// Move Text Box over Unit & Draw Unit Triangle
if (unit != noone) {
	// Text Box Movement
	old_y = y;

	x = unit_draw_x;
	var temp_y = unit_draw_y - ((string_height_ext(display_text, temp_text_separation, text_wrap_width) / 2) + (box_vertical_padding / 2) + box_breath_padding + sprite_get_height(sTextboxTriangle));
	
	if (temp_y == old_y) {
		y = round(temp_y);
	}
	else if (round(temp_y) == old_y) {
		y = old_y;
	}
	else {
		y = temp_y;
	}
	
	// Draw Triangle
	var temp_triangle_y = y + ((string_height_ext(display_text, temp_text_separation, text_wrap_width) / 2) + (box_vertical_padding / 2) + temp_breath_padding);
	draw_sprite(sTextboxTriangle, 0, x, temp_triangle_y);
}

// Draw Roundrect behind Text
draw_set_color(c_black);
draw_roundrect(x - temp_text_width, y - temp_text_height, x + temp_text_width, y + temp_text_height, false);

// Draw Display Text
draw_set_color(font_contrast_color);
draw_text_ext(x, y + 1, display_text, temp_text_separation, text_wrap_width);
draw_text_ext(x + 1, y + 1, display_text, temp_text_separation, text_wrap_width);
draw_set_color(font_color);
draw_text_ext(x, y, display_text, temp_text_separation, text_wrap_width);

// Draw Input Advance Triangle
if (input_advance and !destroy) {
	if (text_index > string_length(text)) {
		// Triangle Variables
		var temp_tri_x = x + temp_text_width + triangle_offset;
		var temp_tri_y = y + temp_text_height + triangle_offset;
		
		var temp_tri_x_1 = temp_tri_x + lengthdir_x(triangle_radius, triangle_draw_angle);
		var temp_tri_y_1 = temp_tri_y + lengthdir_y(triangle_radius, triangle_draw_angle);
		var temp_tri_x_2 = temp_tri_x + lengthdir_x(triangle_radius, triangle_draw_angle + 120);
		var temp_tri_y_2 = temp_tri_y + lengthdir_y(triangle_radius, triangle_draw_angle + 120);
		var temp_tri_x_3 = temp_tri_x + lengthdir_x(triangle_radius, triangle_draw_angle + 240);
		var temp_tri_y_3 = temp_tri_y + lengthdir_y(triangle_radius, triangle_draw_angle + 240);
		
		// Draw Background Triangle
		draw_set_color(c_gray);
		draw_triangle(temp_tri_x_1 + 1, temp_tri_y_1 + 1, temp_tri_x_2 + 1, temp_tri_y_2 + 1, temp_tri_x_3 + 1, temp_tri_y_3 + 1, false);
		
		// Draw Foreground Triangle
		draw_set_color(c_white);
		draw_triangle(temp_tri_x_1, temp_tri_y_1, temp_tri_x_2, temp_tri_y_2, temp_tri_x_3, temp_tri_y_3, false);
	}
}

// Reset Draw Properties
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(1);