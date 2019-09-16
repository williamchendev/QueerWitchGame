/// @description Editor Object Select Update
// Calculates the behavior for the selected object button

// Cease Behaviour if Editor Window Exists
if (instance_exists(oEditorWindow)) {
	return;
}

hover = false;
if (visible) {
	// Checks if mouse is hovering over object selection
	if (abs(mouse_room_y() - y) < 16) {
		if (abs(mouse_room_x() - x) < 16) {
			hover = true;
			// Check if Mouse was pressed
			if (mouse_check_button_pressed(mb_left) and oEditor.editor_click) {
				// Reset selection for all Editor Buttons and select this button
				oEditor.editor_click = false;
				with (oEditorObjectSelect) {
					selected = false;
				}
				with (oEditorObjectBracket) {
					selected = -1;
				}
				selected = true;
			}
		}
	}
}