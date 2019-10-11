/// @description Draw Enemy Event
// draws the enemy to the screen

// Draw enemy Sprite
draw_sprite_ext(sprite_index, image_index, x, y + slope_offset, draw_xscale * image_xscale, draw_yscale, slope_angle, image_blend, image_alpha);

// Draw Arms
var temp_arms1_direction = point_direction(0, 0, arm1_x * draw_xscale, arm1_y * draw_yscale);
var temp_arms1_distance = point_distance(0, 0, arm1_x * draw_xscale, arm1_y * draw_yscale);
var temp_arms2_direction = point_direction(0, 0, arm2_x * draw_xscale, arm2_y * draw_yscale);
var temp_arms2_distance = point_distance(0, 0, arm2_x * draw_xscale, arm2_y * draw_yscale);

var temp_arms1_x = x + lengthdir_x(temp_arms1_distance,  temp_arms1_direction + slope_angle);
var temp_arms1_y = y + lengthdir_y(temp_arms1_distance,  temp_arms1_direction + slope_angle);
var temp_arms2_x = x + lengthdir_x(temp_arms2_distance,  temp_arms2_direction + slope_angle);
var temp_arms2_y = y + lengthdir_y(temp_arms2_distance,  temp_arms2_direction + slope_angle);


//draw_sprite_stretched(sWill_Arms, 0, temp_arms1_x)