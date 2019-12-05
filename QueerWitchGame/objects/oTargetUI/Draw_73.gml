/// @description Insert description here
// You can write your code in this editor

if (target != noone) {
	if (instance_exists(target)) {
		// Draw Target Index
		var temp_sprite_index = target.sprite_index;
		var temp_object_x_scale = target.draw_xscale * target.image_xscale;
		var temp_object_y_scale = target.draw_yscale * target.image_yscale;
		var temp_object_rotation = 0;

		var temp_bbox_left = sprite_get_bbox_left(temp_sprite_index) * temp_object_x_scale;
		var temp_bbox_right = sprite_get_bbox_right(temp_sprite_index) * temp_object_x_scale;
		var temp_bbox_top = sprite_get_bbox_top(temp_sprite_index) * temp_object_y_scale;
		var temp_bbox_bottom = sprite_get_bbox_bottom(temp_sprite_index) * temp_object_y_scale;
	
		temp_bbox_left -= sprite_get_xoffset(temp_sprite_index) * temp_object_x_scale;
		temp_bbox_bottom -= sprite_get_yoffset(temp_sprite_index) * temp_object_y_scale;
		temp_bbox_right -= sprite_get_xoffset(temp_sprite_index) * temp_object_x_scale;
		temp_bbox_top -= sprite_get_yoffset(temp_sprite_index) * temp_object_y_scale;
	
		var temp_object_angle = target.draw_angle;
	
		var temp_point1_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_top);
		var temp_point1_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_top) + temp_object_angle;
		var temp_point2_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_top);
		var temp_point2_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_top) + temp_object_angle;
		var temp_point3_dis = point_distance(0, 0, temp_bbox_right, temp_bbox_bottom);
		var temp_point3_angle = point_direction(0, 0, temp_bbox_right, temp_bbox_bottom) + temp_object_angle;
		var temp_point4_dis = point_distance(0, 0, temp_bbox_left, temp_bbox_bottom);
		var temp_point4_angle = point_direction(0, 0, temp_bbox_left, temp_bbox_bottom) + temp_object_angle;
	
		var temp_left_top_x_offset = lengthdir_x(temp_point1_dis, temp_point1_angle + temp_object_rotation);
		var temp_left_top_y_offset = lengthdir_y(temp_point1_dis, temp_point1_angle + temp_object_rotation);
		var temp_right_top_x_offset = lengthdir_x(temp_point2_dis, temp_point2_angle + temp_object_rotation);
		var temp_right_top_y_offset = lengthdir_y(temp_point2_dis, temp_point2_angle + temp_object_rotation);
		var temp_right_bottom_x_offset = lengthdir_x(temp_point3_dis, temp_point3_angle + temp_object_rotation);
		var temp_right_bottom_y_offset = lengthdir_y(temp_point3_dis, temp_point3_angle + temp_object_rotation);
		var temp_left_bottom_x_offset = lengthdir_x(temp_point4_dis, temp_point4_angle + temp_object_rotation);
		var temp_left_bottom_y_offset = lengthdir_y(temp_point4_dis, temp_point4_angle + temp_object_rotation);
				
		var temp_edge_a = min(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
		var temp_edge_b = max(temp_left_top_x_offset, temp_right_top_x_offset, temp_right_bottom_x_offset, temp_left_bottom_x_offset);
		var temp_edge_c = min(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);
		var temp_edge_d = max(temp_left_top_y_offset, temp_right_top_y_offset, temp_right_bottom_y_offset, temp_left_bottom_y_offset);		

		draw_sprite_ext(sEditorSelect, 0, target.x + temp_edge_a - offset, target.y + temp_edge_c - offset, 1, 1, 0, c_white, 1);
		draw_sprite_ext(sEditorSelect, 0, target.x + temp_edge_a - offset, target.y + temp_edge_d + offset, 1, -1, 0, c_white, 1);
		draw_sprite_ext(sEditorSelect, 0, target.x + temp_edge_b + offset, target.y + temp_edge_d + offset, -1, -1, 0, c_white, 1);
		draw_sprite_ext(sEditorSelect, 0, target.x + temp_edge_b + offset, target.y + temp_edge_c - offset, -1, 1, 0, c_white, 1);

		// Draw Target Info
		var temp_draw_x = target.x + temp_edge_b + offset + 2;
		var temp_draw_y = target.y + temp_edge_c - offset;
	
		draw_set_font(fHeartBit);
	
		// Draw Selected
		if (selected) {
			draw_set_color(c_white);
			draw_rectangle(temp_draw_x, temp_draw_y, temp_draw_x + 42, temp_draw_y + 13, false);
			draw_set_color(c_black);
			drawTextOutline(temp_draw_x + 3, temp_draw_y - 2, c_white, c_black, "Targeted");
			draw_set_color(c_white);
		}
	}
}