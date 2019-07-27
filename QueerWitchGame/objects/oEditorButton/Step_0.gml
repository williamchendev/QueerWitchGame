/// @description Editor Button Update Event
// Calculates the behaviour for the Editor Button

if (mouse_check_button_pressed(mb_left)) {
	var temp_rad_check = sqrt(sqr(mouse_room_x() - x) + sqr(mouse_room_y() - y));
	if (draw_radius > temp_rad_check) {
		with (oEditorButton) {
			selected = false;
		}
		selected = true;
	}
}

var temp_target = radius;
if (selected) {
	temp_target += selected_radius;
}
draw_radius = lerp(draw_radius, temp_target, spd);