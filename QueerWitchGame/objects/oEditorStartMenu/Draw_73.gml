/// @description Editor Start Menu Draw
// Draws the Start Menu to the screen

// Draw Start Menu Title
draw_set_font(fDiest64);
draw_text(x + 14, y + 12, menu_name);
draw_rectangle(x + 8, y + 10, x + string_width(menu_name) + 18, y + 28, true);