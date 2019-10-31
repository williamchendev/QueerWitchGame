/// @description Arm Draw
// Draws the Arm Effect to the Screen

var temp_offset = 0;
if (limb_direction < 0) {
	temp_offset = -1;
}

draw_set_alpha(1);
draw_set_color(c_white);
draw_line_width(limb_anchor_x + temp_offset, limb_anchor_y, point1_x + temp_offset, point1_y, 2);
draw_line_width(point1_x + temp_offset, point1_y, point2_x + temp_offset, point2_y, 2);

draw_set_alpha(1);
draw_set_color(c_red);
draw_point(limb_anchor_x + temp_offset, limb_anchor_y);

draw_set_alpha(1);
draw_set_color(c_white);