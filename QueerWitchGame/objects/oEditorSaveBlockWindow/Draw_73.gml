/// @description Save Block Window Draw
// Draws the Save Block Window to the screen

// Inherit the parent event
event_inherited();

// Draw Save Text
draw_set_font(fHeartBit);
draw_set_halign(fa_center);
draw_text(x + (width / 2), y + 34, progress_text + string_repeat(".", progress_dots + 1));
draw_set_halign(fa_left);

// Draw Progress Bar
draw_rectangle(x + 5, y + 19, x + 215, y + 36, true);
draw_rectangle(x + 7, y + 21, x + (206 * progress) + 7, y + 34, false);