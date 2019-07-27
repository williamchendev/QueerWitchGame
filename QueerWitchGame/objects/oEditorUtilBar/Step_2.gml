/// @description Editor Utility Bar Update Event
// Calculates the behaviour for the Editor Utility Bar

if (start_spacing != spacing) {
	start_spacing = lerp(start_spacing, spacing, 0.08);
	if (abs(spacing - start_spacing) < 0.1) {
		start_spacing = spacing;
	}
}

for (var i = 0; i < array_length_1d(buttons); i++) {
	buttons[i].x = x;
	buttons[i].y = y + (start_spacing * i);
	if (buttons[i].selected) {
		util_type = i;
	}
}