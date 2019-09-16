/// @description Main Object Menu Update
// Calculates the behaviour of the Main Object Selection Menu

// Moves the Editor to the position of the Camera
x = oGameManager.camera_x;
y = oGameManager.camera_y;

// Checks if Mouse clicked on the expand tab for the Main Object Selection Menu
if (!instance_exists(oEditorWindow)) {
	if (mouse_check_button_pressed(mb_left) and oEditor.editor_click) {
		if (abs(mouse_room_y() - (oGameManager.camera_y + (oGameManager.camera_height / 2))) < (oGameManager.camera_height / 2)) {
			if (expanded) {
				// Pushes menu back in if expanded
				if (abs(mouse_room_x() - (oGameManager.camera_x + 113)) < 4) {
					oEditor.editor_click = false;
					expanded = false;
					with (oEditorObjectBracket) {
						visible = false;
					}
					with (oEditorObjectSelect) {
						visible = false;
					}
				}
			}
			else {
				// Pulls menu out if not expanded
				if (abs(mouse_room_x() - (x + 4.5)) < 4) {
					oEditor.editor_click = false;
					expanded = true;
					with (oEditorObjectBracket) {
						visible = true;
					}
				}
			}
		}
	}
}
else {
	// Editor Window Hide Object Select Bracket
	expanded = false;
	with (oEditorObjectBracket) {
		visible = false;
	}
	with (oEditorObjectSelect) {
		visible = false;
	}
}

// Positions all menus along with the scroll wheel and by height of the sub menus
if (expanded) {
	// Resets selected option
	selected = false;
	selected_menu = -1;
	selected_index = -1;
	selected_text = noone;
	
	// Calculates the position of each sub menu based on their height
	var temp_height = 0;
	for (var i = 0; i < array_length_1d(sub_menus); i++) {
		sub_menus[i].x = oGameManager.camera_x;
		sub_menus[i].y = oGameManager.camera_y + temp_height - scroll;
		if (sub_menus[i].expanded) {
			temp_height += (20 + sub_menus[i].height);
		}
		else {
			temp_height += 20;
		}
		
		// Sets all the selection data based
		if (sub_menus[i].selected != -1) {
			selected = true;
			selected_menu = i;
			selected_index = sub_menus[i].selected;
			selected_text = sub_menus[i].bar_name + ": " + sub_menus[i].options[sub_menus[i].selected].button_name;
		}
	}
	
	// Scrolls the sub menus with the mouse wheel
	if (mouse_wheel_up()) {
		scroll -= scroll_spd;
	}
	else if (mouse_wheel_down()) {
		scroll += scroll_spd;
	}

	// Clamps the position of the scroll wheel
	scroll = clamp(scroll, 0, max(0, temp_height - oGameManager.camera_height));
}

backing.x = x;
backing.y = y;
backing.expanded = expanded;
backing.visible = visible;