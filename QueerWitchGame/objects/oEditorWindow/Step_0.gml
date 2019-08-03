/// @description Editor Block Window Update
// Calculates and repositions the elements of Block Window around with the Block Window

// Initiate Destroy Object
if (destroy) {
	destroyed = true;
	for (var i = 0; i < array_length_1d(elements); i++) {
		instance_destroy(elements[i].id);
	}
	instance_destroy(id);
	return;
}

// Mouse Drag
if (drag) {
	if (mouse_check_button(mb_left)) {
		camera_x_offset = (mouse_room_x() - oGameManager.camera_x) - mouse_x_offset;
		camera_y_offset = (mouse_room_y() - oGameManager.camera_y) - mouse_y_offset;
	}
	else {
		drag = false;
	}
}

// Close the Window or Check if Title Bar was selected
if (mouse_check_button_pressed(mb_left)) {
	if (abs((x + width - 5.5) - mouse_room_x()) < 4.5) {
		if (abs((y + 7.5) - mouse_room_y()) < 4.5) {
			if (instance_exists(oEditor)) {
				oEditor.editor_click = false;
			}
			with (oEditorWindow) {
				destroy = false;
			}
			destroy = true;
		}
	}
	else if (abs((x + (width / 2))  - mouse_room_x()) < width / 2) {
		if (abs((y + (title_height / 2)) - mouse_room_y()) < title_height / 2) {
			with (oEditorWindow) {
				drag = false;
			}
			drag = true;
			mouse_x_offset = mouse_room_x() - x;
			mouse_y_offset = mouse_room_y() - y;
		}
	}
}

// Move position to camera offset and camera position
camera_x_offset = clamp(camera_x_offset, 0, oGameManager.camera_width - width - 1);
camera_y_offset = clamp(camera_y_offset, 0, oGameManager.camera_height - (height + title_height) - 1);
camera_x_offset = round(camera_x_offset);
camera_y_offset = round(camera_y_offset);
x = oGameManager.camera_x + camera_x_offset;
y = oGameManager.camera_y + camera_y_offset;

// Move all elements
if (elements != noone) {
	for (var i = 0; i < array_length_1d(elements); i++) {
		var temp_x = element_offset[i, 0];
		var temp_y = element_offset[i, 1];
		elements[i].camera_x_offset = temp_x + camera_x_offset;
		elements[i].camera_y_offset = temp_y + camera_y_offset;
		elements[i].depth = window_depth - (i + 1);
	}
}