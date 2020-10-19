/// @description Arm Draw
// Draws the Arm Effect to the Screen

if (limb_sprite == noone) {
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
}
else {
	var temp_dis_1 = (point_distance(limb_anchor_x, limb_anchor_y, point1_x, point1_y) + 2) / sprite_get_height(limb_sprite);
	var temp_angle_1 = (point_direction(limb_anchor_x, limb_anchor_y, point1_x, point1_y) + 180) - (limb_direction * 90);
	
	var temp_dis_2 = (point_distance(point1_x, point1_y, point2_x, point2_y) + 2) / sprite_get_height(limb_sprite);
	var temp_angle_2 = (point_direction(point1_x, point1_y, point2_x, point2_y) + 180) - (limb_direction * 90);
	
	draw_sprite_ext(limb_sprite, 0, limb_anchor_x, limb_anchor_y, -1, temp_dis_1 * limb_direction, temp_angle_1, c_white, 1); 
	draw_sprite_ext(limb_sprite, 1, point1_x, point1_y, -1, temp_dis_2 * limb_direction, temp_angle_2, c_white, 1); 
}