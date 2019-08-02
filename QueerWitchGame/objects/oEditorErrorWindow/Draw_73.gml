/// @description Error Window Draw

// Inherit the parent event
event_inherited();

// Draw ".txt" text to screen
draw_set_font(fNormalFont);
draw_text(x + 10, y + 18, body_text);