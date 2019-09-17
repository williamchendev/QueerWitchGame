/// @description New Block Window Draw

// Inherit the parent event
event_inherited();

// Draw ".txt" text to screen
draw_set_font(fNormalFont);
draw_text(x + width - 28, y + element_offset[2, 1], ".txt");