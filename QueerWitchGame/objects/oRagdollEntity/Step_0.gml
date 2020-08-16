/// @description Insert description here
// You can write your code in this editor

// Debug


if (held) {
	var px = (mouse_x-x);
	var py = (mouse_y-y);
	phy_speed_x = px;
	phy_speed_y = py;
	
	if (!mouse_check_button(mb_left)) {
		held = false;
	}
}
else {
	if (mouse_check_button_pressed(mb_left)) {
		if (position_meeting(mouse_x, mouse_y, self)) {
			with (oRagdollEntity) {
				held = false;
			}
			held = true;
		}
	}
}