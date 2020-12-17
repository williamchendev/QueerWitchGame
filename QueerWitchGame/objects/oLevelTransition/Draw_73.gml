/// @description Insert description here
// You can write your code in this editor

if (transition_active) {
	//draw_set_alpha(transition_alpha * transition_alpha);
	//draw_set_color(c_black);
	//draw_rectangle(game_manager.camera_x - 50, game_manager.camera_y - 50, game_manager.camera_x + game_manager.camera_width + 50, game_manager.camera_y + game_manager.camera_height + 50, false);
	
	// Transition Variables
	var temp_transition_alpha = transition_alpha * transition_alpha * transition_alpha;
	var temp_transition_lerp = lerp(0, game_manager.game_width + (camera_offset * 2), temp_transition_alpha);
	draw_set_alpha(1);
	draw_set_color(transition_color);
	
	// Draw Transition
	if (transition_other_room_active) {
		var temp_start_x = game_manager.camera_x + game_manager.game_width + camera_offset;
		var temp_end_x = (game_manager.camera_x + game_manager.game_width + camera_offset) - temp_transition_lerp;
		var temp_start_y = game_manager.camera_y - camera_offset;
		var temp_end_y = game_manager.camera_y + game_manager.game_height + camera_offset;
		draw_rectangle(temp_end_x - 1, temp_start_y, temp_start_x, temp_end_y, false);
		draw_triangle(temp_end_x, temp_start_y, temp_end_x, temp_end_y, temp_end_x - camera_offset, temp_end_y, false);
	}
	else {
		var temp_start_x = game_manager.camera_x - camera_offset;
		var temp_end_x = (game_manager.camera_x + temp_transition_lerp) - camera_offset;
		var temp_start_y = game_manager.camera_y - camera_offset;
		var temp_end_y = game_manager.camera_y + game_manager.game_height + camera_offset;
		draw_rectangle(temp_start_x, temp_start_y, temp_end_x + 1, temp_end_y, false);
		draw_triangle(temp_end_x, temp_start_y, temp_end_x, temp_end_y, temp_end_x + camera_offset, temp_start_y, false);
	}
	
	// Draw Reset
	draw_set_color(c_white);
}