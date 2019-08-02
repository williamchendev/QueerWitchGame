/// @description Editor Object Draw Event
// Draw the editor button to the screen

// Set the alpha of the hovering
var hover_alpha = max(hover, 0.6);
if (selected) {
	// If selected, draw a white box behind the selected object and change the alpha
	draw_set_alpha(0.6);
	draw_rectangle(x - 18, y - 18, x + 17, y + 17, false);
	draw_set_alpha(1);
	hover_alpha = 1;
}
// Draw the button
draw_sprite_stretched_ext(button_image, button_index, x - 16, y - 16, 32, 32, c_white, hover_alpha);