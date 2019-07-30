/// @description Editor Button Update Event
// Calculates the behaviour for the Editor Button

// Check if Mouse Click on Button
if (mouse_check_button_pressed(mb_left) and oEditor.editor_click) {
	var temp_rad_check = sqrt(sqr(mouse_room_x() - x) + sqr(mouse_room_y() - y));
	if (draw_radius > temp_rad_check) {
		// Reset all Editor Utility Buttons and set this button as the selected button
		oEditor.editor_click = false;
		with (oEditorButton) {
			selected = false;
		}
		selected = true;
	}
}

// Calculate the radius of the Button
var temp_target = radius;
if (selected) {
	temp_target += selected_radius;
}
draw_radius = lerp(draw_radius, temp_target, spd);