/// @description Insert description here
// You can write your code in this editor

x = oGameManager.camera_x;
y = oGameManager.camera_y;

if (mouse_check_button_pressed(mb_left)) {
	if (abs(mouse_room_y() - (oGameManager.camera_y + (oGameManager.camera_height / 2))) < (oGameManager.camera_height / 2)) {
		if (expanded) {
			if (abs(mouse_room_x() - (oGameManager.camera_x + 113)) < 4) {
				expanded = false;
				with (oEditorObjectBracket) {
					visible = false;
				}
			}
		}
		else {
			if (abs(mouse_room_x() - (x + 4.5)) < 4) {
				expanded = true;
				with (oEditorObjectBracket) {
					visible = true;
				}
			}
		}
	}
}

if (expanded) {
	var temp_height = 0;
	for (var i = 0; i < array_length_1d(sub_menus); i++) {
		sub_menus[i].x = oGameManager.camera_x;
		sub_menus[i].y = oGameManager.camera_y + temp_height - scroll;
		if (sub_menus[i].expanded) {
			temp_height += (20 + (sub_menus[i].height * 36));
		}
		else {
			temp_height += 20;
		}
	}
	
	if (mouse_wheel_up()) {
		scroll -= scroll_spd;
	}
	else if (mouse_wheel_down()) {
		scroll += scroll_spd;
	}

	scroll = clamp(scroll, 0, max(0, temp_height - oGameManager.camera_height));
}

backing.x = x;
backing.y = y;
backing.expanded = expanded;
backing.visible = visible;