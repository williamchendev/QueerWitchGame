/// @description Editor Block Window Draw
// Draws the block window to the screen

// Draws the Background and Bounding Box
draw_set_color(c_black);
draw_rectangle(x, y, x + width, y + height + title_height, false);
draw_set_color(c_white);
draw_rectangle(x, y, x + width, y + title_height, false);
draw_rectangle(x, y, x + width, y + height + title_height, true);

// Draws the Title
draw_set_font(fHeartBit);
drawTextOutline(x + 3, y - 1, c_white, c_black, window_title);
draw_sprite(sEditorClose, 0, x + width - 10, y + 3);