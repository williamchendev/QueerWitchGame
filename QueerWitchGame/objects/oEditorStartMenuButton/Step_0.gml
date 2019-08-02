/// @description Insert description here
// You can write your code in this editor

// Check if Mouse is over Button
if (abs((x + 27.5) - mouse_room_x()) < 26.5) and (abs((y + 9) - mouse_room_y()) < 8) {
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
alpha = clamp(alpha, 0, 1);

if (mouse_check_button_pressed(mb_left)) {
	
}