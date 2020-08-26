/// @description Unit Draw Event
// Draws the unit to the screen

// Draw Unit Sprite
draw_sprite_ext(sprite_index, image_index, x, y, draw_xscale * image_xscale, draw_yscale, draw_angle, draw_color, image_alpha);

// Draw Stats Variables
var temp_stats_x = x - 1;
var temp_stats_y = y - (54 * draw_yscale);

// Draw Health Bar
if (canmove and health_show) {
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

		if (health_points < max_health_points) {
			draw_set_color(health_color_5);
			draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 3, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width + 1, temp_stats_y, false);
		}

		draw_set_color(health_color_1);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 3, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, false);
		draw_set_color(health_color_3);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 1, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y, false);
		draw_set_color(health_color_2);
		draw_rectangle(temp_stats_x - (temp_health_width / 2), temp_stats_y - 2, (temp_stats_x - (temp_health_width / 2)) + temp_health_percent_width, temp_stats_y - 1, false);
	
		// Debug
		/*
		draw_set_font(fHeartBit);
		draw_set_halign(fa_center);
		drawTextOutline(temp_stats_x, temp_stats_y - 10, c_white, c_black, "[" +string(health_points) + "]");
		draw_set_halign(fa_left);
		*/
	}
}

// Debug
if (global.debug) {
	var temp_x = x;
	var temp_y = y;
	
	var temp_sim_velocity = 0;
	var temp_sim_jump_velocity = hold_jump_spd;
	var temp_sim_grav_velocity = 0;
	var temp_sim_djump = false;
	
	temp_sim_velocity -= jump_spd;
	draw_set_color(c_red);
	while (temp_sim_velocity < 0) {
		temp_sim_velocity -= temp_sim_jump_velocity;
		temp_sim_jump_velocity *= jump_decay;
		
		temp_sim_grav_velocity += grav_spd;
		temp_sim_grav_velocity *= grav_multiplier;
		temp_sim_grav_velocity = min(temp_sim_grav_velocity, max_grav_spd);
		temp_sim_velocity += temp_sim_grav_velocity;
		
		temp_x += spd * sign(image_xscale);
		temp_y += temp_sim_velocity;
		
		draw_point(temp_x, temp_y);
		
		if (!temp_sim_djump) {
			if (temp_sim_velocity >= -double_jump_spd) {
				temp_sim_velocity = 0;
				temp_sim_velocity -= double_jump_spd;
				temp_sim_jump_velocity = hold_jump_spd;
				temp_sim_djump = true;
			}
		}
	}
	draw_set_color(c_white);
}