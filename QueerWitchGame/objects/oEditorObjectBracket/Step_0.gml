/// @description Insert description here
// You can write your code in this editor

if (visible) {
	if (mouse_check_button_pressed(mb_left)) {
		if (abs(mouse_room_x() - (x + 53.5)) < 52) {
			if (abs(mouse_room_y() - (y + 8.5)) < 8) {
				expanded = !expanded;
			}
		}
	}

	hover_text = noone;
	for (var i = 0; i < array_length_1d(options); i++) {
		var temp_x_pos = i mod 3;
		var temp_y_pos = floor(i / 3);
		options[i].x = x + 18 + (temp_x_pos * 36);
		options[i].y = y + 31 + (temp_y_pos * 36);
		if (options[i].hover) {
			hover_text = options[i].button_name;
		}
		options[i].visible = expanded;
	}
}
else {
	for (var i = 0; i < array_length_1d(options); i++) {
		options[i].visible = false;
	}
}