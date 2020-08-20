/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_white);
var temp_y = 0;
for (var i = 0; i < 480; i++) {
	temp_y = i;
	if (position_meeting(mouse_x, mouse_y + i, oPlatform)) {
		draw_set_color(c_green);
		break;
	}
	else if (position_meeting(mouse_x, mouse_y + i, oSolid)) {
		draw_set_color(c_red);
		break;
	}
}
draw_line(mouse_x, mouse_y, mouse_x, mouse_y + temp_y);
draw_set_color(c_white);