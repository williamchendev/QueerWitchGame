/// @description Unit Draw Event
// Draws the unit to the screen

// Draw Unit Sprite
draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale * image_xscale, draw_yscale, 0, image_blend, image_alpha);

// Debug Draw Health
var temp_stats_x = x - 1;
var temp_stats_y = y - (54 * draw_yscale);
var temp_health_width = 48;
var temp_health_percent_width = (health_points / max_health_points) * temp_health_width;

var health_color_1 = make_color_rgb(17, 148, 255);
var health_color_2 = make_color_rgb(29, 170, 255);
var health_color_3 = make_color_rgb(41, 182, 255);

draw_set_color(c_black);
draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 3, (temp_stats_x + (temp_health_width / 2)), temp_stats_y, false);

draw_set_color(health_color_2);
draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 3, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, false);
draw_set_color(health_color_1);
draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 1, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, false);
draw_set_color(health_color_3);
draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 2, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y - 1, false);