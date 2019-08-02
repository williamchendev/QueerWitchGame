/// @description Insert description here
// You can write your code in this editor

// Draw Set font
draw_set_font(fInnoFont);

// Draw text
draw_text(x + 6, y + 2, button_name);
	
// Draw select overlay
draw_set_alpha(alpha);
draw_set_color(c_white);
draw_rectangle(x, y, x + (alpha * 55), y + 18, false);
draw_set_color(c_black);
draw_text(x + 6, y + 2, button_name);

// Reset Draw Variables
draw_set_alpha(1);
draw_set_color(c_white);