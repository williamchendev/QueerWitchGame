/// @description Editor Utility Bar Update Event
// Calculates the behaviour for the Editor Utility Bar

// Lerp spacing of the options for the init
if (start_spacing != spacing) {
	start_spacing = lerp(start_spacing, spacing, 0.08);
	if (abs(spacing - start_spacing) < 0.1) {
		start_spacing = spacing;
	}
}

// Update position of the buttons & update selected utility
for (var i = 0; i < array_length_1d(buttons); i++) {
	buttons[i].x = x;
	buttons[i].y = y + (start_spacing * i);
	if (buttons[i].selected) {
		util_type = i;
	}
}