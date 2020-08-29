/// @description Level Editor Update Event
// Calculates the functionality and behaviour of the Level Editor

// Editor Mode Behaviours
if (editor_mode == editortypes.start) {
	if (!instance_exists(oEditorStartMenu)) {
		instance_create_layer(x, y, layer, oEditorStartMenu);
	}
}
else if (editor_mode == editortypes.block) {
	// Movement
	if (keyboard_check(ord("W"))) {
		y -= editor_spd;
	}
	else if (keyboard_check(ord("S"))) {
		y += editor_spd;
	}
	
	if (keyboard_check(ord("A"))) {
		x -= editor_spd;
	}
	else if (keyboard_check(ord("D"))) {
		x += editor_spd;
	}
	
	// Set Snap/Free Draw
	editor_snap = !keyboard_check(vk_control);
		
	// Editor Utility Bar
	editor_tools.x = oGameManager.camera_x + oGameManager.camera_width - 20;
	editor_tools.y = oGameManager.camera_y + 20;
}

// Reset the Editor Click check and Editor Cursor sprite
editor_click = true;
editor_cursor = -1;

// Camera Movement
if (camera_follow) {
	var target_pos_x = x;
	var target_pos_y = y;
	
	var camera = view_camera[0];
	//var cam_width = camera_get_view_width(camera);
	//var cam_height = camera_get_view_height(camera);
	var cam_x = camera_get_view_x(camera);
	var cam_y = camera_get_view_y(camera);
	
	var cam_target_x = lerp(cam_x, target_pos_x, camera_follow_spd);
	var cam_target_y = lerp(cam_y, target_pos_y, camera_follow_spd);
	
	camera_set_view_pos(camera, cam_target_x, cam_target_y);
	
	oGameManager.camera_width = camera_get_view_width(view_camera[0]);
	oGameManager.camera_height = camera_get_view_height(view_camera[0]);
	oGameManager.camera_x = camera_get_view_x(view_camera[0]);
	oGameManager.camera_y = camera_get_view_y(view_camera[0]);
}