/// @description Debug Draw Event
// Draws Game Manager Debug Info to the screen

// Check if Debugging mode is active 
if (global.debug) {
	// Draw Set Font
	draw_set_font(fNormalFont);
	
	// Draw Debug Mode Active
	drawTextOutline(camera_x + debug_x_offset, camera_y + debug_y_offset, c_white, c_black, "Debug Mode Active");
	
	// Draw Debug Variable Bracket
	draw_set_color(c_black);
	draw_line(camera_x + debug_x_offset - 2, camera_y + debug_y_offset + 15, camera_x + debug_x_offset + 97, camera_y + debug_y_offset + 15);
	draw_line(camera_x + debug_x_offset - 3, camera_y + debug_y_offset + 16, camera_x + debug_x_offset + 98, camera_y + debug_y_offset + 16);
	draw_line(camera_x + debug_x_offset - 2, camera_y + debug_y_offset + 17, camera_x + debug_x_offset + 97, camera_y + debug_y_offset + 17);
	draw_set_color(c_white);
	draw_line(camera_x + debug_x_offset - 2, camera_y + debug_y_offset + 16, camera_x + debug_x_offset + 97, camera_y + debug_y_offset + 16);
	
	// Draw Time Modifier
	debug_fps_timer -= global.realdeltatime;
	if (debug_fps_timer <= 0) {
		debug_fps = round(fps_real);
		debug_fps_timer = 30;
	}
	drawTextOutline(camera_x + debug_x_offset, camera_y + debug_y_offset + 17, c_white, c_black, "Time: " + string(time_spd));
	drawTextOutline(camera_x + debug_x_offset, camera_y + debug_y_offset + 28, c_white, c_black, "FPS: " + string(debug_fps));
}