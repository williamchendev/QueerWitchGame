/// @description Editor Button Draw Event
// Draws the Editor Button to the Screen

// Set the button visual properties based on if it was selected
var inside_circle = 0;
if (selected) {
	var color_a = c_white;
	var color_b = c_black;
	inside_circle = 1.5;
}
else {
	var color_a = c_black;
	var color_b = c_white;
}

// Draw the Button
draw_set_color(color_a);
draw_circle(x, y, draw_radius, false);
draw_set_color(color_b);
draw_circle(x, y, draw_radius - inside_circle, true);
draw_sprite_ext(sEditorUtil, button_index, x, y, 1, 1, 0, color_b, 1);

// Reset the color
draw_set_color(c_white);