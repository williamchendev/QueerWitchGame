/// @description Editor Start Menu Update
// Calculates the behaviour of the level editor start menu

// Position Snap to Upper Left side of Camera
x = oGameManager.camera_x;
y = oGameManager.camera_y;
for (var i = 0; i < array_length_1d(buttons); i++) {
	buttons[i].x = x + 14;
	buttons[i].y = y + 34 + (i * 18);
}

// Button Behaviour
if (menu_pause) {
	// Set button Pause
	for (var i = 0; i < array_length_1d(buttons); i++) {
		buttons[i].pause = true;
	}
	
	if (!instance_exists(oEditorWindow)) {
		// Reset Buttons
		for (var i = 0; i < array_length_1d(buttons); i++) {
			buttons[i].pause = false;
			buttons[i].pressed = false;
		}
		
		menu_pause = false;
	}
}
else {
	// Button Press Actions
	if (play_demo.pressed) {
		instance_create_layer(x, y, layer, oEditorPlayDemoWindow);
	}
	if (new_level.pressed) {
		
	}
	if (open_level.pressed) {
		
	}
	if (new_block.pressed) {
		instance_create_layer(x, y, layer, oEditorNewBlockWindow);
	}
	if (open_block.pressed) {
		
	}
	
	// Find Button Selected
	for (var i = 0; i < array_length_1d(buttons); i++) {
		if (buttons[i].pressed) {
			menu_pause = true;
			break;
		}
	}
}