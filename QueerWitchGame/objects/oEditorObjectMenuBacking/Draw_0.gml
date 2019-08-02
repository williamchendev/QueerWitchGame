/// @description Object Menu Backing Draw
// Draws the back of the level editor to the screen

draw_set_color(c_black);
if (expanded) {
	// Draws the Expanded version of the level editor back with the side bar expand button
	draw_rectangle(x - 10, y - 10, x + 117, y + oGameManager.camera_height + 10, false);
	draw_set_color(c_white);
	draw_line(x + 108, y - 10, x + 108, y + oGameManager.camera_height + 10);
	draw_line(x + 117, y - 10, x + 117, y + oGameManager.camera_height + 10);
	draw_sprite_ext(sEditorExpand, 0, x + 113, y + (oGameManager.camera_height / 2), -1, 1, 0, c_white, 1);
}
else {
	// Draws the side bar expand button to the side without the expanded level editor
	draw_rectangle(x - 9, y - 10, x + 9, y + oGameManager.camera_height + 10, false);
	draw_set_color(c_white);
	draw_line(x + 9, y - 10, x + 9, y + oGameManager.camera_height + 10);
	draw_sprite(sEditorExpand, 0, x + 5, y + (oGameManager.camera_height / 2));
}

draw_set_color(c_white);