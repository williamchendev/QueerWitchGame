/// @description Insert description here
// You can write your code in this editor

hover = false;
if (visible) {
	if (abs(mouse_room_y() - y) < 16) {
		if (abs(mouse_room_x() - x) < 16) {
			hover = true;
			if (mouse_check_button_pressed(mb_left)) {
				with (oEditorObjectSelect) {
					selected = false;
				}
				selected = true;
			}
		}
	}
}