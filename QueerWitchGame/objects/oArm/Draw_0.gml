/// @description Arm Draw
// Draws the Arm Effect to the Screen

draw_set_alpha(1);
draw_set_color(c_white);
draw_line_width(limb_anchor_x, limb_anchor_y, point1_x, point1_y, 2);
draw_line_width(point1_x, point1_y, point2_x, point2_y, 2);