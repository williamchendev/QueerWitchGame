/// @description Arm Draw
// Draws the Arm Effect to the Screen

var temp_offset = 0;
if (limb_direction < 0) {
	temp_offset = -1;
}

//draw_set_alpha(1);
//draw_set_color(c_white);
//draw_line_width(limb_anchor_x + temp_offset, limb_anchor_y, point1_x + temp_offset, point1_y, 2);
//draw_line_width(point1_x + temp_offset, point1_y, point2_x + temp_offset, point2_y, 2);

var temp_dis_1 = point_distance(limb_anchor_x, limb_anchor_y, point1_x, point1_y) / 9;
var temp_angle_1 = point_direction(limb_anchor_x, limb_anchor_y, point1_x, point1_y) + 90;
draw_sprite_ext(sWilliam_Arms1, 0, limb_anchor_x, limb_anchor_y, 1, temp_dis_1, temp_angle_1, c_white, 1); 

//draw_set_alpha(1);
//draw_set_color(c_red);
//draw_point(limb_anchor_x + temp_offset, limb_anchor_y);

var temp_dis_2 = point_distance(point1_x, point1_y, point2_x, point2_y) / 9;
var temp_angle_2 = point_direction(point1_x, point1_y, point2_x, point2_y) + 90;
draw_sprite_ext(sWilliam_Arms2, 0, point1_x, point1_y, 1, temp_dis_2, temp_angle_2, c_white, 1); 

//draw_set_alpha(1);
//draw_set_color(c_white);