/// @description Insert description here
// You can write your code in this editor

if (interact_select_draw_value > 0) {
	if (instance_exists(game_manager)) {
		if (surface_exists(interact_surface)) {
			// Draw Surface Overlay
			draw_set_alpha(interact_select_draw_value * interact_select_draw_value);
			draw_surface(interact_surface, game_manager.surface_manager.draw_x, game_manager.surface_manager.draw_y);
			draw_set_alpha(1);
		}
	}
}