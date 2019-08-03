/// @description Start Menu Button Update
// Calculates the behaviour of the Start Menu Button

// Check if Mouse is over Button
if (!pause) {
	if (abs((x + 27.5) - mouse_room_x()) < 26.5) and (abs((y + 9) - mouse_room_y()) < 8) {
		if (mouse_check_button_pressed(mb_left)) {
			alpha = 1;
			pressed = true;
		}

		if (alpha < 1) {
			alpha = alpha + 0.025;
			alpha *= 1.09;
		}
	}
	else {
		if (alpha > 0) {
			alpha = alpha - 0.01;
			alpha *= 0.9;
		}
	}
}

// Clamp Alpha
alpha = clamp(alpha, 0, 1);