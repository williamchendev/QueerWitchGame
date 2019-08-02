/// @description Editor Button Input Update
// Calculates the behaviour of the Button Input

// Inherit the parent event
event_inherited();

// Check if Mouse Hover
var temp_check = false;
if (abs((x + (width / 2)) - mouse_room_x()) < width / 2) {
	if (abs((y + (height / 2)) - mouse_room_y()) < height / 2) {
		temp_check = true;
	}
}

if (temp_check) {
	hover = true;
	if (press) {
		if (mouse_check_button_released(mb_left)) {
			with (oEditorInput) {
				selected = false;
			}
			pressed = true;
		}
		if (!mouse_check_button(mb_left)) {
			press = false;
		}
	}
	else {
		if (mouse_check_button_pressed(mb_left)) {
			press = true;
		}
	}
}
else {
	hover = false;
	if (!mouse_check_button(mb_left)) {
		press = false;
	}
}