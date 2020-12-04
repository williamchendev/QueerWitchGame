/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

/*
// Draw Legs
for (var i = 0; i < array_height_2d(leg_anchor); i++) {
	// Find Leg Anchors
	var temp_leg_anchor_distance = point_distance(0, 0, leg_anchor[i, 0] * sign(image_xscale), leg_anchor[i, 1]);
	var temp_leg_anchor_direction = point_direction(0, 0, leg_anchor[i, 0] * sign(image_xscale), leg_anchor[i, 1]);
	var temp_leg_anchor_x = x + lengthdir_x(temp_leg_anchor_distance, temp_leg_anchor_direction + draw_angle);
	var temp_leg_anchor_y = y + lengthdir_y(temp_leg_anchor_distance, temp_leg_anchor_direction + draw_angle);
	
	// Find Leg End
	var temp_leg_end_x = leg_end[i, 0];
	var temp_leg_end_y = leg_end[i, 1];
	
	// Check For Point
	if (leg_grounded[i]) {
		draw_line_width(temp_leg_anchor_x, temp_leg_anchor_y, temp_leg_end_x, temp_leg_end_y, 2);
	}
}
*/