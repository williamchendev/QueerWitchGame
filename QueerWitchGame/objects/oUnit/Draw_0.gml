/// @description Unit Draw Event
// Draws the unit to the screen

// Draw Unit Sprite
draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale * image_xscale, draw_yscale, 0, image_blend, image_alpha);

// Draw Stats Variables
var temp_stats_x = x - 1;
var temp_stats_y = y - (54 * draw_yscale);

// Draw Health Bar
if (health_show) {
	if (health_points > 0) {
		var temp_health_width = 48;
		var temp_health_percent_width = (health_points / max_health_points) * temp_health_width;
		
		var health_color_1 = make_color_rgb(209, 19, 54);
		var health_color_2 = make_color_rgb(181, 24, 52);
		var health_color_3 = make_color_rgb(150, 30, 52);

		var health_color_4 = make_color_rgb(92, 25, 37);
		var health_color_5 = make_color_rgb(222, 213, 215);

		draw_set_color(health_color_4);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 3, (temp_stats_x + (temp_health_width / 2)), temp_stats_y, false);

		draw_set_color(health_color_1);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 3, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, false);
		draw_set_color(health_color_3);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 1, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, false);
		draw_set_color(health_color_2);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 2, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y - 1, false);

		if (health_points < max_health_points) {
			draw_set_color(health_color_5);
			draw_rectangle((temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y - 3, false);
		}
	
		// Debug
		/*
		draw_set_font(fHeartBit);
		draw_set_halign(fa_center);
		drawTextOutline(temp_stats_x, temp_stats_y - 10, c_white, c_black, "[" +string(health_points) + "]");
		draw_set_halign(fa_left);
		*/
	}
}